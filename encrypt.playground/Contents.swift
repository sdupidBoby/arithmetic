#if os(macOS)
import Cocoa
#else
import UIKit
#endif


/**
 *   编码
 */
func base64Encoding(plainString:String)->String
{
    let plainData = plainString.data(using: String.Encoding.utf8)
    let base64String = plainData?.base64EncodedString()
    return base64String!
}

/**
 *   解码
 */
func base64Decoding(encodedString:String)->String
{
    guard let decodedData = Data(base64Encoded: encodedString) else { return "" }
    let decodedString = String.init(data: decodedData, encoding: String.Encoding.utf8)
    return decodedString!
}

let tmpstring = "123456781234567812345678"
let encodestring =  base64Encoding(plainString: tmpstring)
let decodestring =  base64Decoding(encodedString: encodestring)



print(" orignString:\(tmpstring)\n encodeString:\(encodestring) \n decodeString:\(decodestring)")
