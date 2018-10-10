#!/bin/sh
set -e
set -u
set -o pipefail

if [ -z ${UNLOCALIZED_RESOURCES_FOLDER_PATH+x} ]; then
    # If UNLOCALIZED_RESOURCES_FOLDER_PATH is not set, then there's nowhere for us to copy
    # resources to, so exit 0 (signalling the script phase was successful).
    exit 0
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

# This protects against multiple targets copying the same framework dependency at the same time. The solution
# was originally proposed here: https://lists.samba.org/archive/rsync/2008-February/020158.html
RSYNC_PROTECT_TMP_FILES=(--filter "P .*.??????")

case "${TARGETED_DEVICE_FAMILY:-}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  3)
    TARGET_DEVICE_ARGS="--target-device tv"
    ;;
  4)
    TARGET_DEVICE_ARGS="--target-device watch"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\"" || true
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE="$RESOURCE_PATH"
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH" || true
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "${PODS_ROOT}/../../../Development/CCDPods/HBHybridKit/HBHybridKit/Assets/Resource.bundle"
  install_resource "${PODS_ROOT}/MJRefresh/MJRefresh/MJRefresh.bundle"
  install_resource "${PODS_ROOT}/PinYin4Objc/PinYin4Objc/Resources/unicode_to_hanyu_pinyin.txt"
  install_resource "${PODS_ROOT}/TDFCategories/Resources/en.lproj"
  install_resource "${PODS_ROOT}/TDFCategories/Resources/th.lproj"
  install_resource "${PODS_ROOT}/TDFCategories/Resources/zh-Hans.lproj"
  install_resource "${PODS_ROOT}/TDFCategories/Resources/zh-Hant.lproj"
  install_resource "${PODS_ROOT}/TDFCore/TDFCore/Assets/Media.xcassets/core_right_side_background.imageset/菜类@2x.png"
  install_resource "${PODS_ROOT}/TDFCore/TDFCore/Assets/Media.xcassets/core_right_side_background.imageset/菜类@3x.png"
  install_resource "${PODS_ROOT}/TDFCore/TDFCore/Assets/Media.xcassets"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/export.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/export.imageset/export@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/export.imageset/export@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_batch_Issue.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_batch_Issue.imageset/icon_batch_Issue@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_batch_Issue.imageset/icon_batch_Issue@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_footer_button_shopCardToChain.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_footer_button_shopCardToChain.imageset/icon_footer_button_shopCardToChain@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_footer_button_shopCardToChain.imageset/icon_footer_button_shopCardToChain@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_batch_pick.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_batch_pick.imageset/ico_batch_pick@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_batch_pick.imageset/ico_batch_pick@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_batchRebewal.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_batchRebewal.imageset/ico_footer_batchRebewal@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_batchRebewal.imageset/ico_footer_batchRebewal@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_addshop.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_addshop.imageset/ico_footer_button_addshop@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_addshop.imageset/ico_footer_button_addshop@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_batch.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_batch.imageset/ico_footer_button_batch_red@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_batch.imageset/ico_footer_button_batch_red@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_checkall.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_checkall.imageset/ico_footer_button_checkall@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_checkall.imageset/ico_footer_button_checkall@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_printBill.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_printBill.imageset/ico_footer_button_printBill@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_printBill.imageset/ico_footer_button_printBill@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_search.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_search.imageset/ico_footer_button_search@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_search.imageset/ico_footer_button_search@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sendMessage.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sendMessage.imageset/ico_footer_button_sendMessage@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sendMessage.imageset/ico_footer_button_sendMessage@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sort.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sort.imageset/ico_footer_button_sort@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sort.imageset/ico_footer_button_sort@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_uncheckall.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_uncheckall.imageset/ico_footer_button_uncheckall@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_uncheckall.imageset/ico_footer_button_uncheckall@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_buyField.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_buyField.imageset/ico_footer_buyField_red@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_buyField.imageset/ico_footer_buyField_red@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_videoCustomer.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_videoCustomer.imageset/ico_footer_videoCustomer@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_videoCustomer.imageset/ico_footer_videoCustomer@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_rnd_green.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_rnd_green.imageset/ico_rnd_green_red@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_rnd_green.imageset/ico_rnd_green_red@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/export.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_batch_Issue.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_footer_button_shopCardToChain.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_batch_pick.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_batchRebewal.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_addshop.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_batch.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_checkall.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_printBill.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_search.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sendMessage.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sort.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_uncheckall.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_buyField.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_videoCustomer.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_rnd_green.imageset"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_back.imageset/common_nbc_back.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_back.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_cancel.imageset/common_nbc_cancel.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_cancel.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_ok.imageset/common_nbc_ok.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_ok.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_blue.imageset/back@2x.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_blue.imageset/back@3x.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_blue.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_white.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_white.imageset/w@2x.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_white.imageset/w@3x.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_back.imageset"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_cancel.imageset"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_ok.imageset"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_blue.imageset"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_white.imageset"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/animal_breviary.imageset/动物@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/animal_breviary.imageset/动物@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/animal_day.imageset/动物-日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/animal_night.imageset/动物-夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/black_white_breviary.imageset/bg_normal1_rd@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/black_white_breviary.imageset/bg_normal1_rd@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/black_white_day.imageset/黑白_日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/black_white_night.imageset/黑白_夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/bridge_breviary.imageset/bg_bridge2_rd@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/bridge_breviary.imageset/bg_bridge2_rd@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/bridge_day.imageset/桥_日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/bridge_night.imageset/桥_夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/chinoiserie_breviary.imageset/中国风@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/chinoiserie_breviary.imageset/中国风@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/chinoiserie_day.imageset/中国风-日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/chinoiserie_night.imageset/中国风-夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/food_breviary.imageset/美食@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/food_breviary.imageset/美食@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/food_day.imageset/美食-日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/food_night.imageset/美食-夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/green_breviary.imageset/花@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/green_breviary.imageset/花@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/green_day.imageset/绿_日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/green_night.imageset/绿_夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/sea_breviary.imageset/风景@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/sea_breviary.imageset/风景@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/sea_day.imageset/海_日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/sea_night.imageset/海_夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme1_breviary.imageset/Bitmap.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme1_day.imageset/1.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme1_night.imageset/2.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme2_breviary.imageset/22.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme2_day.imageset/3.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme2_night.imageset/ 4.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme_weather_breviary.imageset/粘贴图片@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme_weather_breviary.imageset/粘贴图片@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/TDFHomeTheme.plist"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "${PODS_ROOT}/../../../Development/CCDPods/HBHybridKit/HBHybridKit/Assets/Resource.bundle"
  install_resource "${PODS_ROOT}/MJRefresh/MJRefresh/MJRefresh.bundle"
  install_resource "${PODS_ROOT}/PinYin4Objc/PinYin4Objc/Resources/unicode_to_hanyu_pinyin.txt"
  install_resource "${PODS_ROOT}/TDFCategories/Resources/en.lproj"
  install_resource "${PODS_ROOT}/TDFCategories/Resources/th.lproj"
  install_resource "${PODS_ROOT}/TDFCategories/Resources/zh-Hans.lproj"
  install_resource "${PODS_ROOT}/TDFCategories/Resources/zh-Hant.lproj"
  install_resource "${PODS_ROOT}/TDFCore/TDFCore/Assets/Media.xcassets/core_right_side_background.imageset/菜类@2x.png"
  install_resource "${PODS_ROOT}/TDFCore/TDFCore/Assets/Media.xcassets/core_right_side_background.imageset/菜类@3x.png"
  install_resource "${PODS_ROOT}/TDFCore/TDFCore/Assets/Media.xcassets"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/export.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/export.imageset/export@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/export.imageset/export@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_batch_Issue.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_batch_Issue.imageset/icon_batch_Issue@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_batch_Issue.imageset/icon_batch_Issue@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_footer_button_shopCardToChain.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_footer_button_shopCardToChain.imageset/icon_footer_button_shopCardToChain@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_footer_button_shopCardToChain.imageset/icon_footer_button_shopCardToChain@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_batch_pick.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_batch_pick.imageset/ico_batch_pick@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_batch_pick.imageset/ico_batch_pick@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_batchRebewal.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_batchRebewal.imageset/ico_footer_batchRebewal@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_batchRebewal.imageset/ico_footer_batchRebewal@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_addshop.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_addshop.imageset/ico_footer_button_addshop@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_addshop.imageset/ico_footer_button_addshop@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_batch.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_batch.imageset/ico_footer_button_batch_red@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_batch.imageset/ico_footer_button_batch_red@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_checkall.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_checkall.imageset/ico_footer_button_checkall@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_checkall.imageset/ico_footer_button_checkall@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_printBill.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_printBill.imageset/ico_footer_button_printBill@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_printBill.imageset/ico_footer_button_printBill@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_search.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_search.imageset/ico_footer_button_search@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_search.imageset/ico_footer_button_search@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sendMessage.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sendMessage.imageset/ico_footer_button_sendMessage@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sendMessage.imageset/ico_footer_button_sendMessage@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sort.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sort.imageset/ico_footer_button_sort@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sort.imageset/ico_footer_button_sort@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_uncheckall.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_uncheckall.imageset/ico_footer_button_uncheckall@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_uncheckall.imageset/ico_footer_button_uncheckall@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_buyField.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_buyField.imageset/ico_footer_buyField_red@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_buyField.imageset/ico_footer_buyField_red@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_videoCustomer.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_videoCustomer.imageset/ico_footer_videoCustomer@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_videoCustomer.imageset/ico_footer_videoCustomer@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_rnd_green.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_rnd_green.imageset/ico_rnd_green_red@2x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_rnd_green.imageset/ico_rnd_green_red@3x.png"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/export.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_batch_Issue.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/icon_footer_button_shopCardToChain.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_batch_pick.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_batchRebewal.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_addshop.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_batch.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_checkall.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_printBill.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_search.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sendMessage.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_sort.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_button_uncheckall.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_buyField.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_footer_videoCustomer.imageset"
  install_resource "${PODS_ROOT}/TDFFooterKit/TDFFooterKit/Assets/Media.xcassets/red/ico_rnd_green.imageset"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_back.imageset/common_nbc_back.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_back.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_cancel.imageset/common_nbc_cancel.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_cancel.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_ok.imageset/common_nbc_ok.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_ok.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_blue.imageset/back@2x.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_blue.imageset/back@3x.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_blue.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_white.imageset/Contents.json"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_white.imageset/w@2x.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_white.imageset/w@3x.png"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_back.imageset"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_cancel.imageset"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/common_nbc_ok.imageset"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_blue.imageset"
  install_resource "${PODS_ROOT}/TDFNavigationBarKit/TDFNavigationBarKit/Assets/Media.xcassets/core_icon_back_white.imageset"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/animal_breviary.imageset/动物@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/animal_breviary.imageset/动物@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/animal_day.imageset/动物-日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/animal_night.imageset/动物-夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/black_white_breviary.imageset/bg_normal1_rd@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/black_white_breviary.imageset/bg_normal1_rd@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/black_white_day.imageset/黑白_日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/black_white_night.imageset/黑白_夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/bridge_breviary.imageset/bg_bridge2_rd@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/bridge_breviary.imageset/bg_bridge2_rd@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/bridge_day.imageset/桥_日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/bridge_night.imageset/桥_夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/chinoiserie_breviary.imageset/中国风@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/chinoiserie_breviary.imageset/中国风@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/chinoiserie_day.imageset/中国风-日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/chinoiserie_night.imageset/中国风-夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/food_breviary.imageset/美食@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/food_breviary.imageset/美食@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/food_day.imageset/美食-日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/food_night.imageset/美食-夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/green_breviary.imageset/花@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/green_breviary.imageset/花@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/green_day.imageset/绿_日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/green_night.imageset/绿_夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/sea_breviary.imageset/风景@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/sea_breviary.imageset/风景@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/sea_day.imageset/海_日.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/sea_night.imageset/海_夜.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme1_breviary.imageset/Bitmap.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme1_day.imageset/1.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme1_night.imageset/2.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme2_breviary.imageset/22.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme2_day.imageset/3.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme2_night.imageset/ 4.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme_weather_breviary.imageset/粘贴图片@2x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets/theme_weather_breviary.imageset/粘贴图片@3x.png"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/TDFHomeTheme.plist"
  install_resource "${PODS_ROOT}/TDFThemeKit/TDFThemeKit/Resources/Media.xcassets"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "${XCASSET_FILES:-}" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "${PODS_ROOT}*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  if [ -z ${ASSETCATALOG_COMPILER_APPICON_NAME+x} ]; then
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  else
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${TARGET_TEMP_DIR}/assetcatalog_generated_info_cocoapods.plist"
  fi
fi
