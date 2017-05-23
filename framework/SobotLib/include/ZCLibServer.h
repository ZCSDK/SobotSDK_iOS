//
//  ZCLibServer.h
//  ZCLibLib
//
//  Created by zhangxy on 15/10/22.
//  Copyright © 2015年 ZCLib. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "ZCLibMessageConstants.h"
#import "ZCLibStatusDefine.h"
#import "ZCLibConfig.h"


/**
 *  ZC 接口核心类。
 *  <p/>
 *  所有 ZC 相关方法、监听器都由此调用和设置。
 */
@interface ZCLibServer : NSObject

/**
 *  获取核心操作类对象
 *  【注意：本方法不是单例模式，需要使用时自行保持对象为全局变量】
 *  @return 智齿核心处理类实例。
 */
+ (ZCLibServer *)getLibServer;

/**
 *  是否显示调试信息
 *
 *  @param isDebug 
 */
-(BOOL) isShowDebug;
-(void) setDebug:(BOOL) isDebug;


/**
 指定host测试，调试使用

 @return <#return value description#>
 */
-(NSString *) getAPIHost;
-(void) setHost:(NSString *) testHost;


/**
 *  连接到智齿客服
 成功调用一次就可以，主要初始化一些必要参数，自动连接人工服务通道
  初始化参数,必须先设置[ZCLibClient getZCLibClient].libInitInfo
 *
 *  @param
 *  @param successBlock         初始化成功，返回初始化对象，同 getZClibConfig
 *  @param errorBlock           初始化失败，返回失败状态
 *  @param sysNumIncorrectBlock 企业编号错误
 */
- (void)initSobotSDK:(void (^)(ZCLibConfig *config))successBlock
                 error:(void (^)(ZCNetWorkCode status))errorBlock
       appIdIncorrect:(void (^)(NSString *appId))appIdIncorrectBlock;


/**
 *  转接人工
 *
 *  @param groupId     技能组
 *  @param groupName   技能组编号
 *  @param aid         对接客服ID
 *  @param tranFlag    是否必须转入指定客服
 *  @param isWaiting   当前是不是重复点击
 *  @param startBlock  开始请求
 *  @param errorBlock  转接失败
 *  @param resultBlock 请求结果
 */
-(void)connectOnlineCustomer:(NSString *) groupId
                   groupName:(NSString *) groupName
                      config:(ZCLibConfig *) _config
                         Aid:(NSString *) aid
                    TranFlag:(int) tranFlag
                     current:(BOOL) isWaiting
                       start:(void(^)())startBlock
                      result:(void (^)(NSDictionary *dict, ZCConnectUserStatusCode status)) resultBlock;

/**
 *  拼接显示对象
 *
 *  @param text          显示的文字
 *  @param msgType       消息类型
 *  @param voiceDuration 如果是音频，就是音频时长
 *  @param style         提示信息，还是普通信息
 *  @param isSend        是否是发送者消息
 *  @param nickname      发送的昵称
 *  @param count         排队人数
 *  @param isOpen        开启留言
 *
 *  @return             ZCLibMessage
 */
-(ZCLibMessage *)setLocalDataToArr:(int) action
                              type:(int)msgType
                          duration:(NSString *) voiceDuration
                             style:(NSInteger) style
                              send:(BOOL) isSend
                              name:(NSString *)nickname
                           content:(NSString *)count
                            config:(ZCLibConfig *) config;



/**
 *
 *  发送消息
 跟进ZCLibConfig中的类型，自动判断
 *
 *  @param docId    引导说辞的问题编号
 *  @param message  消息体
 *  @param type     消息类型
 *  @param duration 声音长度，如00:20,字符串类型，直接用于显示
 *  @param startBlock    开始发送，返回用于显示的消息模型
 *  @param successBlock  发送成功，返回用于显示状态的消息模型
 *  @param progressBlock 发送进度，主要是图片和语言需要
 *  @param failBlock     发送失败，包括内容为空、文件不纯在、网络错误等，返回用于显示状态的消息模型，如果消息未发送，没有模型返回
 */
-(void)sendMessage:(NSString *)message
          questionId:(NSString*)docId
           msgType:(ZCMessageType ) type
          duration:(NSString *)duration
            config:(ZCLibConfig *)config
         robotFlag:(NSString *)roboflag
             start:(void(^)(ZCLibMessage *message)) startBlock
           success:(void(^)(ZCLibMessage *message,ZCMessageSendCode sendCode)) successBlock
          progress:(void(^)(ZCLibMessage *message)) progressBlock
              fail:(void(^)(ZCLibMessage *message,ZCMessageSendCode errorCode)) failBlock;




/**
 获取机器人引导语

 @param config 初始化信息
 @param robotId 机器人编号(指定机器人时配置)
 @param startBlock 开始
 @param successBlock 成功
 @param failBlock 失败
 */
- (void)getRobotGuide:(ZCLibConfig *) config
            robotFlag:(NSString *) robotId
                start:(void(^)(ZCLibMessage *message)) startBlock
              success:(void(^)(ZCLibMessage *message,ZCMessageSendCode sendCode)) successBlock
                 fail:(void(^)(ZCLibMessage *message,ZCMessageSendCode errorCode)) failBlock;


/**
 *  获取用户cid列表
 *  @param time 历史记录的有效时间范围 单位为分钟，默认为0（有效范围10分钟到48小时之间）
 *  @param config    ZCLibConfig 对象
 *  @param startBlock 开始
 *  @param successBlock 成功
 *  @param failBlock 失败
 **/

/**
 获取历史记录所有cid

 @param time
 历史记录时间范围，单位分钟(例:100-表示从现在起前100分钟的会话)
 @param config 初始化返回的配置对象，（仅使用uid）
 @param startBlock 开始
 @param successBlock 成功
 @param failBlock 失败
 */
-(void)getChatUserCids:(int) time
                config:(ZCLibConfig *) config
                 start:(void(^)()) startBlock
               success:(void(^)(NSDictionary *dict,ZCNetWorkCode sendCode)) successBlock
                failed:(void(^)(NSString *errorMessage,ZCNetWorkCode errorCode)) failedBlock;

/**
 *  获取历史记录
 *
 *  @param cid       当前要查询的cid
 *  @param startBlock   开始查询
 *  @param successBlock 查询成功
 *  @param failedBlock  查询失败
 */
-(void)getHistoryMessages:(NSString *) cid
                  withUid:(NSString *) uid
                    start:(void(^)()) startBlock
                  success:(void(^)(NSMutableArray *messages,ZCNetWorkCode sendCode)) successBlock
                   failed:(void(^)(NSString *errorMessage,ZCNetWorkCode errorCode)) failedBlock;


/**
 *  评价客户
 *
 *  @param params 参数说明
 cid 会话编号
 isresolve 是否解决问题，1是没有解决，0解决
 problem = 问题编号，没有传空 机器人：答非所问1 理解能力差2 问题不能回答3 不礼貌4  人工： 服务态度差,5  回答不及时,6 没解决问题,7 不礼貌,8
 source 分数（✨）
 suggest 描述
 type   0评价机器人，1评价人工
 userId 用户uid
 */
-(void)doComment:(NSMutableDictionary *) params;


/**
 *  发送留言
 *  @param ticketContent 工单内容
 *  @param customerEmail 邮箱地址
 *  @param customerPhone 手机号码
 */
-(void)sendLeaveMessage:(NSMutableDictionary *) params
                 config:(ZCLibConfig *) config
                success:(void (^)(ZCNetWorkCode code,int status,NSString *msg))successBlock
                 failed:(void (^)(NSString *errorMessage, ZCNetWorkCode erroCode))failedBlock;



/**
 *  获取技能组
 *  @param  startBlock     开始请求的回调
 *  @param  successBlock   请求成功的回调
 *  @param  failedBlock    请求失败的回调
 */
-(void)getSkillSet:(ZCLibConfig *) config
             start:(void (^)())startBlock
           success:(void(^)(NSMutableArray *messages,ZCNetWorkCode sendCode)) successBlock
            failed:(void(^)(NSString *errorMessage,ZCNetWorkCode errorCode)) failedBlock;



/**
 *  发送正在输入内容
 *
 *  @param content      正在输入的文本内容
 *  @param successBlock
 *  @param failedBlock  
 */
-(void)sendInputContent:(ZCLibConfig *) config
                content:(NSString *) content
                success:(void(^)(ZCNetWorkCode sendCode)) successBlock
                 failed:(void(^)(NSString *errorMessage,ZCNetWorkCode errorCode)) failedBlock;



/**
 *  登出
 */
-(void)logOut:(ZCLibConfig *) config;



/**
 退出推送
 */
-(void)loginOutPush:(void(^)(NSString *userId,NSData *token,NSError *err)) resultBlock;

/**
 *  下载文件
 *
 *  @param url           文件URL
 *  @param startBlock    开始下载
 *  @param successBlock  下载完成
 *  @param progressBlock 下载进度
 *  @param failBlock     下载结束
 */
-(void)downFileWithURL:(NSString *)url
             start:(void(^)()) startBlock
           success:(void(^)(NSData *data)) successBlock
          progress:(void(^)(float progress)) progressBlock
              fail:(void(^)(ZCNetWorkCode errorCode)) failBlock;


/**
 *  清空历史消息
 *
 *  @param uid 用户id
 */
-(void)cleanHistoryMessage:(NSString *) uid
                   success:(void(^)(NSData *data)) successBlock
                      fail:(void(^)(ZCNetWorkCode errorCode)) failBlock;


/**
config: 获取uid、cid、robotFlag
commentMessage：获取 docId 词条ID，docName 词条名称
Integer status 反馈结果-顶/踩 1 顶 0 踩
 */
-(void)rbAnswerComment:(ZCLibConfig *) config
               message:(ZCLibMessage *) commentMessage
                status:(int) status
                 start:(void(^)())startBlock
               success:(void(^)(ZCNetWorkCode code)) successBlock
                  fail:(void(^)(ZCNetWorkCode errorCode)) failBlock;


/**
 @parma filePath:文件路径
 @parma commanyId: 企业编号
 */
-(void)fileUploadForLeave:(NSString *) filePath
                commanyId:(NSString *) commanyId
                    start:(void(^)())startBlock
                  success:(void(^)(NSString *fileURL,ZCNetWorkCode code)) successBlock
                     fail:(void(^)(ZCNetWorkCode errorCode)) failBlock;

@end
