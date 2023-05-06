//
//  Model.swift
//  BeinSports
//
//  Created by mo_fathy on 01/05/2023.
//
import Foundation

struct EventsResult: Codable {
    var success: Int?
    var result: [Event]
}

struct Event: Codable {
    var event_key: Int?
    var event_date: String?
    var event_date_start: String?
    var event_time: String?
    var event_home_team: String?
    var event_away_team: String?
    var event_final_result: String?
    var country_name: String?
    var league_name: String?
    var league_key: Int?
    var league_round: String?
    var league_season: String?
    var event_live: String?
    var event_stadium: String?
    var event_referee: String?
    var home_team_logo: String?
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    var away_team_logo: String?
    var event_country_key: Int?
    var league_logo: String?
    var country_logo: String?
    
    
    var event_second_player_logo: String?
    var event_first_player_logo: String?
    var event_first_player: String?
    var event_second_player: String?
    var first_player_key: Int?
    var second_player_key: Int?
}



struct TeamsResult: Codable {
    var success: Int?
    var result: [Teams]
}

struct Teams: Codable {
    var team_key: Int?
    var team_name: String?
    var team_logo: String?
    var players: [Player]?
}

struct PlayerResult: Codable {
    var success: Int
    var result: [Player]
}

struct Player: Codable{
    var player_name: String?
    var player_type: String?
    var player_number: String?
    var player_image: String?
    var team_name: String?
    var player_goals: String?
    var player_yellow_cards: String?
    var  player_red_cards: String?
    var player_assists: String?
    var player_minutes: String?
    var player_match_played: String?
    var player_is_captain: String?
    var player_shots_total: String?
    var  player_goals_conceded: String?
    var  player_fouls_commited: String?
    var  player_tackles: String?
    var  player_blocks: String?
    
    var player_key: Int?
    var player_country: String?
    var player_bday: String?
    var player_logo: String?
    var player_age: String?
    var player_rating: String?

   

}


struct ResultsResult: Codable {
    var success: Int?
    var result: [Result]
}

struct Result: Codable {
    var event_key: Int?
    var event_date: String?
    var event_date_stop: String?
    var event_time: String?
    var event_home_team: String?
    var event_away_team: String?
    var event_final_result: String?
    var event_home_final_result: String?
    var event_away_final_result: String?
    var country_name: String?
    var league_name: String?
    var league_key: Int?
    var league_round: String?
    var league_season: String?
    var event_live: String?
    var event_stadium: String?
    var event_referee: String?
    var home_team_logo: String?
    var event_home_team_logo: String?
    var away_team_logo: String?
    var event_away_team_logo: String?
    var event_country_key: Int?
    var league_logo: String?
    var country_logo: String?
    
    var event_second_player_logo: String?
    var event_first_player_logo: String?
    var event_first_player: String?
    var event_second_player: String?
}

struct videoResult: Codable {
    var success: Int
    var result: [video]
}

struct video: Codable {
    var event_key: Int
    var video_title_full, video_title: String
    var video_url: String

}


