module MonsterGroup exposing (MonsterGroup, Monster, newMonsterGroup)

import MonsterConfig exposing (MonsterClassConfig)


type alias MonsterGroup =
    { class : String
    , level : Int
    , health : Int
    , movement : Int
    , damage : Int
    , range : Int
    , maxCount : Int
    , monsters : List Monster
    }


newMonsterGroup : MonsterClassConfig -> MonsterGroup
newMonsterGroup config =
    { class = config.name
    , level = 1
    , health = config.level1.normal.health
    , movement = config.level1.normal.movement
    , damage = config.level1.normal.damage
    , range = config.level1.normal.range
    , maxCount = config.number
    , monsters = newMonsterList config.name config.number config.level1.normal.health
    }


type alias Monster =
    { class : String
    , monsterId : Int
    , maxHealth : Int
    , damageTaken : Int
    }


newMonsterList : String -> Int -> Int -> List Monster
newMonsterList class n health =
    (List.map (newMonster class health) (List.range 1 n))


newMonster : String -> Int -> Int -> Monster
newMonster class health monsterId =
    { class = class
    , monsterId = monsterId
    , maxHealth = health
    , damageTaken = 0
    }
