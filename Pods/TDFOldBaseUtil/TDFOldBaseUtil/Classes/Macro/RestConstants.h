//
//  RestContants.h
//  RestApp
//  二维火后台 平台的常数。
//  Created by zxh on 14-3-19.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#ifndef RestApp_RestContants_h
#define RestApp_RestContants_h


#import "RestAppConstants.h"
#import "RemoteResult.h"
#import <TDFNetworking/TDFNetworking.h>


#define ASSIGN_BY_ENTITYID_URL @"/AssignPadServer?eId=%@&key=%@&type=2"

//二维码生成规则.座位二维码生成规则 entityId, seatcode, key.
//#define SEAT_QR_CODE @"http://weidian.2dfire.com/ma/order/%@/%@/%@" //外网
//#define SEAT_QR_CODE @"http://api.l.whereask.com/ma/order/%@/%@/%@"  //内网

#define WX_REQ_TOKEN @"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code"

#define WX_REQ_USERINFO @"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@"

#define WX_INSTALL_URL @"itms-apps://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8"

#define FILE_SERVER_URL @"%@/imageUpload"

//URL路径格式.
#define URL_PATH_FORMAT @"%@/%@"

//卡包背景图.
#define BG_FILE @"bgFile"

//餐店编码.
#define SHOP_CODE @"shopcode"

//餐店名称.
#define SHOP_NAME @"shopname"

//商品单位.
#define MENU_UNIT @"menuunit"

//用户名ID.
#define USER_ID @"userid"

//memberID.
#define MEMBER_ID @"memberid"

//用户是否是超级管理员.
#define USER_IS_SUPER @"userIsSuper"

//用户是否切换账户.
#define USER_IS_CHANGESHOP @"userIsChangeShop"

// * <code>职级</code>.
#define ROLE_NAME @"rolername"

//用户名
#define USER_NAME @"username"

//用户姓名.
#define REAL_NAME @"realname"

//员工姓名.
#define EMPLOYEE_NAME @"employeename"

//用户手机号码
#define USER_MOBILE @"usermobile"

//用户密码
#define USER_PASS @"userpass"

//实体Id.
#define ENTITY_ID @"entityid"

//实体Id.
#define BRANCH_ENTITY_ID @"branchEntityId"

//店铺城市Id.
#define CITY_ID @"cityId"

//1:钻木,2:连锁,3:店铺,4:会员卡,5:品牌,6:机构,9:分公司
#define ENTITY_TYPE_ID @"ENTITY_TYPE_ID"

//* 0：单店  1、 连锁总部 2、连锁门店
#define ENTITY_TYPE @"entityType"

//旧ENTITY_ID.
#define ROOT_ENTITY_ID @"root_entityid"

//店家Id.
#define SHOP_ID @"shopid"

//会话Id.
#define SESSION_ID @"sessionid"

//token
#define TOKEN @"token"

//店铺模式.
#define REST_MODE @"restmode"

//当前的手机号码.
#define CURRENT_MOBILE @"currentMobile"

//缺省的商品单位.
#define DEFAULT_MENU_UNITS @"份|例|瓶|个|杯"

//上次添加的商品分类.
#define DEFAULT_KINDMENU @"default_kindmenu"

//上次添加的套餐分类.
#define DEFAULT_SUITKINDMENU @"default_suitkindmenu"

//上次添加的区域.
#define DEFAULT_AREA @"default_area"

//上次添加的职级.
#define DEFAULT_ROLE @"default_role"

//是否是连锁
#define IS_BRAND @"isBrand"

//是否是分公司
#define IS_BRANCH @"isBranch"

//BRANDID
#define BRANDID @"brandId"

//是否是连锁带出来的店
#define IS_REFRESH @"isRefresh"

//1 总部切门店 2 分公司切门店 3 连锁切分公司 4分公司切分公司 5连锁直接登录 6分公司直接登录 7单店（门店）直接登录
#define SHOP_CHANGE_TYPE @"shopChangeType"

#define SESSION_KEY @"session_key"

//------------------供应链新增----------------------

//-------------原料---------------
//上次添加的原料分类ID.
#define DEFAULT_KINDRAW_ID @"default_kindraw_id"

//上次添加的原料分类名称.
#define DEFAULT_KINDRAW_NAME @"default_kindraw_name"

//上次添加的原料主单位ID.
#define DEFAULT_MAINUNIT_ID @"default_mainunit_id"

//上次添加的原料主单位名称.
#define DEFAULT_MAINUNIT_NAME @"default_mainunit_name"

//上次添加的数量单位ID.
#define DEFAULT_NUMBERUNIT_ID @"default_numberunit_id"
//上次添加的重量单位ID.
#define DEFAULT_WEIGHTUNIT_ID @"default_weightunit_id"

//允许门店添加原料开关
#define SHOP_MANAGE_MATERIAL @"shop_manage_material"

//收货仓库
#define INPUT_WAREHOUSE @"input_warehouse"

//发货仓库
#define OUTPUT_WAREHOUSE @"output_warehouse"

//-----------导出邮箱--------------
#define EXPORT_EMAIL @"EXPORT_EMAIL"

//原料导出邮箱
#define MATERIAL_EXPORT_EMAIL @"MATERIAL_EXPORT_EMAIL"

//----------------------------------------

//自己的邮箱地址.
#define SELF_MAIL_ADDR @"selfmailaddress"


///版本控制
#define VERSION @"version"
#endif
