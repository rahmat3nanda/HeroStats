//
//  Hero.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Foundation

public enum HeroAttackType: String, Codable {
    case melee = "Melee"
    case ranged = "Ranged"
}

public enum HeroPrimaryAttr: String, Codable {
    case agi = "agi"
    case all = "all"
    case int = "int"
    case str = "str"
}

public enum HeroRole: String, Codable {
    case carry = "Carry"
    case disabler = "Disabler"
    case durable = "Durable"
    case escape = "Escape"
    case initiator = "Initiator"
    case nuker = "Nuker"
    case pusher = "Pusher"
    case support = "Support"
    case all = "All"
}

public struct HeroItem: Codable {
    public let id: Int
    public let name: String
    public let primaryAttr: HeroPrimaryAttr
    public let attackType: HeroAttackType
    public let roles: [HeroRole]
    public let img, icon: String
    public let baseHealth: Int
    public let baseHealthRegen: Double
    public let baseMana: Int
    public let baseManaRegen: Double
    public let baseArmor, baseMr, baseAttackMin, baseAttackMax: Int
    public let baseStr, baseAgi, baseInt: Int
    public let strGain, agiGain, intGain: Double
    public let attackRange, projectileSpeed: Int
    public let attackRate: Double
    public let baseAttackTime: Int
    public let attackPoint: Double
    public let moveSpeed: Int
    public let turnRate: Double?
    public let cmEnabled: Bool
    public let legs, dayVision, nightVision: Int
    public let localizedName: String
    public let the1_Pick, the1_Win, the2_Pick, the2_Win: Int
    public let the3_Pick, the3_Win, the4_Pick, the4_Win: Int
    public let the5_Pick, the5_Win, the6_Pick, the6_Win: Int
    public let the7_Pick, the7_Win, the8_Pick, the8_Win: Int
    public let turboPicks: Int
    public let turboPicksTrend: [Int]
    public let turboWINS: Int
    public let turboWINSTrend: [Int]
    public let proPick, proWin, proBan, pubPick: Int
    public let pubPickTrend: [Int]
    public let pubWin: Int
    public let pubWinTrend: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles, img, icon
        case baseHealth = "base_health"
        case baseHealthRegen = "base_health_regen"
        case baseMana = "base_mana"
        case baseManaRegen = "base_mana_regen"
        case baseArmor = "base_armor"
        case baseMr = "base_mr"
        case baseAttackMin = "base_attack_min"
        case baseAttackMax = "base_attack_max"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
        case strGain = "str_gain"
        case agiGain = "agi_gain"
        case intGain = "int_gain"
        case attackRange = "attack_range"
        case projectileSpeed = "projectile_speed"
        case attackRate = "attack_rate"
        case baseAttackTime = "base_attack_time"
        case attackPoint = "attack_point"
        case moveSpeed = "move_speed"
        case turnRate = "turn_rate"
        case cmEnabled = "cm_enabled"
        case legs
        case dayVision = "day_vision"
        case nightVision = "night_vision"
        case localizedName = "localized_name"
        case the1_Pick = "1_pick"
        case the1_Win = "1_win"
        case the2_Pick = "2_pick"
        case the2_Win = "2_win"
        case the3_Pick = "3_pick"
        case the3_Win = "3_win"
        case the4_Pick = "4_pick"
        case the4_Win = "4_win"
        case the5_Pick = "5_pick"
        case the5_Win = "5_win"
        case the6_Pick = "6_pick"
        case the6_Win = "6_win"
        case the7_Pick = "7_pick"
        case the7_Win = "7_win"
        case the8_Pick = "8_pick"
        case the8_Win = "8_win"
        case turboPicks = "turbo_picks"
        case turboPicksTrend = "turbo_picks_trend"
        case turboWINS = "turbo_wins"
        case turboWINSTrend = "turbo_wins_trend"
        case proPick = "pro_pick"
        case proWin = "pro_win"
        case proBan = "pro_ban"
        case pubPick = "pub_pick"
        case pubPickTrend = "pub_pick_trend"
        case pubWin = "pub_win"
        case pubWinTrend = "pub_win_trend"
    }
}
