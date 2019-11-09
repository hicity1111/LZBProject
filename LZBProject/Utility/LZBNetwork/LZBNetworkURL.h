//
//  LZBNetworkURL.h
//  LZBProject
//
//  Created by 刘义增 on 2019/10/25.
//  Copyright © 2019 hicity. All rights reserved.
//

#ifndef LZBNetworkURL_h
#define LZBNetworkURL_h


#define SafeNetUrl          @"http://plan-api.abnertech.com"
#define SafeNetUrl_Alpha    @"http://sit-api.abnertech.com"

//#define SafeNetUrl_Alpha    @"http://192.168.7.157:8082"


//本地URL
#define SafeLocalUrl        @"http://192.168.7.254:19101"

//#define SafeLocalUrl        @"http://192.168.7.157:8082"


#define BaseURL_QRCode      @"https://sit-wechat.abnertech.com"
#define Agrement_URL        @"http://agreement.abnertech.com"

#ifdef DEBUG
    #define BASEURL(urlStr) [NSString stringWithFormat:@"%@%@", SafeLocalUrl, urlStr]
#else
    #define BASEURL(urlStr) [NSString stringWithFormat:@"%@%@", SafeNetUrl, urlStr]
#endif

#define LoginUrl_sim        @"/api/system/student/login"
#define LoginUrl_full       BASEURL(LoginUrl_sim)

#define HomeWork_Student    @"/api/app/homework/student/list"
#define HomeWork_full       BASEURL(HomeWork_Student)

#define CTBSSubject_sim     @"/api/wrongquestion/subject"
#define CTBSSubject_full    BASEURL(CTBSSubject_sim)

//消息中心
//学生消息列表
#define NotifyListAPI  @"/studentApi/student/notice/getList"
#define NotifyListAPI_full  BASEURL(NotifyListAPI)

#endif /* LZBNetworkURL_h */
