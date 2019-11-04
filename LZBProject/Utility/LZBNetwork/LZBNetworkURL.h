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

#define BaseURL_QRCode      @"https://sit-wechat.abnertech.com"

#ifdef DEBUG
    #define BASEURL(urlStr) [NSString stringWithFormat:@"%@%@", SafeNetUrl_Alpha, urlStr]
#else
    #define BASEURL(urlStr) [NSString stringWithFormat:@"%@%@", SafeNetUrl, urlStr]
#endif

#define LoginUrl_sim    @"/api/system/student/login"

#define LoginUrl_full   BASEURL(LoginUrl_sim)




//消息中心
//学生消息列表
#define NotifyListAPI  @"/api/notice/student/getList"
#define NotifyListAPI_full  BASEURL(NotifyListAPI)

#endif /* LZBNetworkURL_h */
