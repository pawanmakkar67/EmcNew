/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper


struct HomeModel : Mappable {
    var assessments : [Assessments]?
    var sessions : [Sessions]?
    var group_therapy : [Group_therapy]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        assessments <- map["assessments"]
        sessions <- map["sessions"]
        group_therapy <- map["group_therapy"]
    }

}

struct Sessions : Mappable {
    var id : String?
    var time_of_event : String?
    var first_name : String?
    var therapist : String?
    var user_id : String?
    var therapist_id : String?
    var is_complete : String?
    var status : String?
    var video_platform : String?
    var session_length : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        time_of_event <- map["time_of_event"]
        first_name <- map["first_name"]
        therapist <- map["therapist"]
        user_id <- map["user_id"]
        therapist_id <- map["therapist_id"]
        is_complete <- map["is_complete"]
        status <- map["status"]
        video_platform <- map["video_platform"]
        session_length <- map["session_length"]
    }

}

struct Assessments : Mappable {
    var id : String?
    var time_of_event : String?
    var first_name : String?
    var therapist : String?
    var user_id : String?
    var is_complete : String?
    var therapist_id : String?
    var status : String?
    var video_platform : String?
    var session_length : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        time_of_event <- map["time_of_event"]
        first_name <- map["first_name"]
        therapist <- map["therapist"]
        user_id <- map["user_id"]
        is_complete <- map["is_complete"]
        therapist_id <- map["therapist_id"]
        status <- map["status"]
        video_platform <- map["video_platform"]
        session_length <- map["session_length"]
    }

}

struct Group_therapy : Mappable {
    var id : String?
    var time_of_event : String?
    var title : String?
    var first_name : String?
    var participant_ids : String?
    var session_group_id : String?
    var phone_id : String?
    var user_id : String?
    var therapist_id : String?
    var zoom_meeting_id : String?
    var therapist : String?
    var is_complete : String?
    var status : String?
    var session_queue_id : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        time_of_event <- map["time_of_event"]
        title <- map["title"]
        first_name <- map["first_name"]
        participant_ids <- map["participant_ids"]
        session_group_id <- map["session_group_id"]
        phone_id <- map["phone_id"]
        user_id <- map["user_id"]
        therapist_id <- map["therapist_id"]
        zoom_meeting_id <- map["zoom_meeting_id"]
        therapist <- map["therapist"]
        is_complete <- map["is_complete"]
        status <- map["status"]
        session_queue_id <- map["session_queue_id"]
    }

}
