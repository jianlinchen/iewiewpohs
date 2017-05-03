//
//  API.h
//  Wei_Shop
//
//  Created by Geniune on 15/11/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#ifndef API_h
#define API_h

#endif /* API_h */


/*----------------------------打包前注意更换对应环境--------------------------*/
//开发环境-Start

//#define BASE_URL    @"http://192.168.1.58:9099/service/"

//内部开发环境-End

//测试环境-Start
//#define BASE_URL    @"http://192.168.1.56:9099/service/"

//测试环境-End

//上架或者上线环境-Start
#define BASE_URL @"http://merchant.api.wmwbeautysalon.com/service/"

//上架或者上线环境-End
/*----------------------------打包前注意更换对应环境--------------------------*/

//接口文档中请求具体的URL

#pragma mark - 预约信息模块
//预约信息模块获取列表 add by lijian
#define ShopAppointmentList     @"shop/appointment/list"
//商户确认预约 add by lijian
#define ConfirmAppointment @"shop/appointment/confirm"
//商户删除预约 add by lijian
#define DeleteAppointment @"shop/appointment/delete"

#pragma mark - Login模块
//登录接口 add by lijian
#define MbrLogin     @"merchant/common/login"
//获取公钥 add by lijian
#define GetPublicKey @"common/sys/getPublicKey"
//设备注册 add by lijian
#define DeviceRegister @"device/registerDevice"

#pragma mark - 首页
//广告Banner数据接口 add by lijian
#define AdvertList @"advert/common/list"

#pragma mark - 商户验券模块
//商户验券历史记录 add by lijian
#define VerifyList @"coupon/verify/list"
//商户获取优惠券领取信息 add by lijian
#define Verifyinfo @"coupon/verify/info"
//商户验券 add by lijian
#define VerifyUse @"coupon/verify/use"

#pragma mark - 在线咨询模块
//消息盒子消息列表 add by lijian
#define ChatList @"message/chat/listUserSender"
//发送消息接口 add by lijian
#define SendChat @"message/chat/sendChat"
//IM消息列表 add by lijian
#define IMList @"message/chat/listChat"

//获取本店会员列表add by cjl
#define CommonList @"customer/common/list"


//获取群发的历史记录add by cjl
#define QunList @"message/msg/list"

//获取群发的历史记录add by cjl
#define QunSendMessage @"message/msg/add"



//获取客户详情add by cjl
#define DetailCustomer @"customer/common/detail"

//修改商户备注add by cjl
#define setBeiCustomer @"customer/relation/remark"

//扫描用户端授权码，获取用户信息add by cjl
#define ScanCustomer @"customer/relation/auth/info"



//添加账号add by cjl
#define AddCustomer @"customer/relation/auth/add"


//	会员-删除add by cjl
#define DeleteCustomer @"customer/relation/delete"

//	门店-基本信息add by cjl
#define StoreDetail @"shop/common/info"


//意见反馈add by cjl
#define StoreFeed @"common/sys/feedback"

//3.2.4	商户-修改密码 by cjl
#define PassWord @"merchant/common/updatePwd"

//3.4.2	门店-图片-列表获取 by cjl
#define PictureStore @"shop/common/imgList"

//3.4.2	门店-图片-列表获取 by cjl
#define appUpdate @"VersionUpdateServlet"

//3.4.2	预约未读数目 by cjl
#define ShopAppointment @"shop/appointment/countNew"

//3.4.2	版本更新 by cjl
#define CheckVersion @"common/sys/checkVersion"


//3.4.2	优惠券模块接口 by cjl
#define Seguecoupon @"coupon/common/list"


//3.6.1门店服务 by cjl
#define SegueService @"service/common/list"


//3.5.1	门店产品-列表获取 by cjl
#define SegueProduct @"product/common/list"

//3.4.2	门店-咨询-列表 by cjl
#define FeeedCoustomerList @"shop/comment/list"

//3.4.3	门店-咨询-回复取 by cjl
#define FeeedCoustomer @"shop/comment/echo"



//3.4.3	扫描内容获取信息类型 by cjl
#define ScanOr @"scan/common/getType"















