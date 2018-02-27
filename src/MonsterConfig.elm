module MonsterConfig exposing (getMonsterClassConfig, MonsterClassConfig)

import Dict


type alias MonsterClassConfig =
    { name : String
    , number : Int
    , level1 : LevelConfig

    -- , level2 : LevelConfig
    -- , level3 : LevelConfig
    -- , level4 : LevelConfig
    -- , level5 : LevelConfig
    -- , level6 : LevelConfig
    -- , level7 : LevelConfig
    -- , level8 : LevelConfig
    -- , level9 : LevelConfig
    }


type alias LevelConfig =
    { normal : StatsConfig
    , elite : StatsConfig
    }


type alias StatsConfig =
    { health : Int
    , movement : Int
    , damage : Int
    , range : Int
    }


getMonsterClassConfig : String -> MonsterClassConfig
getMonsterClassConfig class =
    case (Dict.get class monsterClassConfigDict) of
        Nothing ->
            { name = "none"
            , number = 1
            , level1 =
                { normal =
                    { health = 0
                    , movement = 0
                    , damage = 0
                    , range = 0
                    }
                , elite =
                    { health = 0
                    , movement = 0
                    , damage = 0
                    , range = 0
                    }
                }
            }

        Just val ->
            val


monsterClassConfigDict : Dict.Dict String MonsterClassConfig
monsterClassConfigDict =
    Dict.fromList
        [ ( "Ooze"
          , { name = "Ooze"
            , number = 10
            , level1 =
                { normal =
                    { health = 3
                    , movement = 1
                    , damage = 1
                    , range = 0
                    }
                , elite =
                    { health = 4
                    , movement = 1
                    , damage = 1
                    , range = 0
                    }
                }
            }
          )
        , ( "Bandit"
          , { name = "Bandit"
            , number = 6
            , level1 =
                { normal =
                    { health = 5
                    , movement = 2
                    , damage = 2
                    , range = 0
                    }
                , elite =
                    { health = 6
                    , movement = 2
                    , damage = 2
                    , range = 0
                    }
                }
            }
          )
        ]
