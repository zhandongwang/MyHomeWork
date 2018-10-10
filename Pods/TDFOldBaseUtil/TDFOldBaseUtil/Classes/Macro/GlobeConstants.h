//
//  GlobeConstants.h
//  Pods
//
//  Created by chaiweiwei on 2016/10/6.
//
//
#define IsfirstLoadbusiness @"isfirstLoadbusiness"//判断是否加载数据

#define RGBA(r,g,b,a)  [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#define OPER_INDEX_BIND 1
#define OPER_SELECT_SHOP 2
#define OPER_ENTER_SHOP 3

//宏定义 Action常数
#define ACTION_CONSTANTS_VIEW 0
#define ACTION_CONSTANTS_ADD 1
#define ACTION_CONSTANTS_EDIT 2
#define ACTION_CONSTANTS_DEL 3
#define ACTION_CONSTANTS_DELALL 4
#define ACTION_CONSTANTS_SORT 5

//公共控件初始化tag
#define TAG_ABOUTVIEW 2001
#define TAG_BACKGROUNDVIEW 2002
#define TAG_MESSAGEBOX 2004
#define TAG_CALENDARBOX 2005
#define TAG_MEMOINPUTBOX 2006
#define TAG_NUMBERINPUTBOX 2007
#define TAG_PAIRPICKERBOX 2008
#define TAG_RATIOPICKERBOX 2009
#define TAG_OPTIONSELECTBOX 2010
#define TAG_MAILINPUTBOX 2011
#define TAG_BIGIMAGEBOX 2012
#define TAG_IMAGESCROLLBOX 2013
#define TAG_FEEDBACKVIEW 2014
#define TAG_IMAGEBOX 2015
#define TAG_NETWORKBOX 2016
#define TAG_TIMEPICKERBOX 2017
#define TAG_DATEPICKERBOX 2018
#define TAG_OPTIONPICKERBOX 2019
#define TAG_OPTIONSELECTVIEW 2020

//宏定义 标题栏图片
#define Head_ICON_BACK @"icon_back.png"
#define Head_ICON_BANGWX @"ico_bangWXcount"
#define Head_ICON_NONE @"ico_none.png"
#define Head_ICON_HELP @"ico_help_w.png"
#define Head_ICON_OK @"ico_ok.png"
#define Head_ICON_CANCEL @"ico_cancel.png"
#define Head_ICON_CATE @"ico_cate.png"
#define Head_ICON_MORE @"ico_more.png"
#define HEAD_ICON_PAST_MONTH @"ico_nav_past_month.png"
#define Head_ICON_DELETE @"ico_delete.png"
#define Head_ICON_PUBLISH @"ico_publish.png"
#define Head_ICON_IMPORT @"ico_import.png"
#define Head_ICON_CHOOSE @"ico_choose.png"
#define Head_ICON_CONFIRM @"ico_confirm.png"
#define Head_ICON_COMMIT @"ico_commit.png"

#define Notification_UI_Edit_Data_Changed @"Notification_UI_Edit_Data_Changed" //ShuPian新增: 为Navigation bar item变化新增一个通知 2016-04-15
#define USER_RELOGIN_NOTIFICATION @"USER_RELOGIN_NOTIFICATION"      //用户重新登录.
#define CanGoToScanCodeViewController @"CanGoToScanCodeViewController" ///判断是否可以进二维码扫描页（应用程序在后台时使用3dtouch）
#define isNeedScanCodeViewController @"isNeedScanCodeViewController" ///判断是否需要进二维码扫描页(应用程序被杀死时使用3dtouch需要）

#define Notification_Logout_Session @"Notification_Logout_Session" //退出登录
#define Notification_BgImage__Change @"Notification_BgImage__Change"  //全局背景变化.
#define Notification_Permission_Change @"Notification_Permission_Change"  //登录权限变化.

#define Notification_UserInfo_Change @"Notification_UserInfo_Change"  //登录用户变化.

#define Notification_ShopWorkStatus_Change @"Notification_ShopWorkStatus_Change"  //工作店铺变化-没有工作的店铺.

#define UI_MAIN_SHOW_NOTIFICATION @"UI_MAIN_SHOW_NOTIFICATION"      //显示主视图.

#define UI_LOGO_SHOW_NOTIFICATION @"UI_LOGO_SHOW_NOTIFICATION"      //侧栏LOGO
#define UI_OTHER_SHOW_NOTIFICATION @"UI_OTHER_SHOW_NOTIFICATION"      //侧栏
#define UI_OTHER_HIDDEN_NOTIFICATION @"UI_OTHER_HIDDEN_NOTIFICATION"

#import <TDFNetworking/TDFNetworkingConstants.h>
