# WBNetSupport


import Alamofire
import WBNetSupport

let headers: HTTPHeaders =  WBHTTPHeaders.shared.header(wuid: "user11111111111", user_event: "testEvent0001")
print(headers)

Alamofire.request("http://t.weather.sojson.com/api/weather/city/101030100", method: .get, parameters: nil, headers: headers).responseJSON { (response) in
if let JSON = response.result.value {
print("JSON: \(JSON)")
}
}



