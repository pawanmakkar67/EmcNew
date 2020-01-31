/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct loginDataModel : Mappable {
	var id : String?
	var has_linked_accounts : String?
	var first_name : String?
	var last_name : String?
	var phone : String?
	var state : String?
	var role_id : String?
	var group_id : String?
	var country : String?
	var timezone : String?
	var timezone_str : String?
	var signature : String?
	var license : String?
	var has_agreed_tos : String?
	var token : String?
	var has_billing : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		has_linked_accounts <- map["has_linked_accounts"]
		first_name <- map["first_name"]
		last_name <- map["last_name"]
		phone <- map["phone"]
		state <- map["state"]
		role_id <- map["role_id"]
		group_id <- map["group_id"]
		country <- map["country"]
		timezone <- map["timezone"]
		timezone_str <- map["timezone_str"]
		signature <- map["signature"]
		license <- map["license"]
		has_agreed_tos <- map["has_agreed_tos"]
		token <- map["token"]
		has_billing <- map["has_billing"]
	}

}
