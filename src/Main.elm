module Main exposing (..)

import Html exposing (Html, button, div, text, span, li, ul)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { monsterGroups : List MonsterGroup
    }


type alias MonsterGroup =
    { monsterClass : String
    , monsters : List Monster
    }

newMonsterGroup : String -> Int -> MonsterGroup
newMonsterGroup class n =
    { monsterClass = class
    , monsters = newMonsterList n
    }

type alias Monster =
    { monsterId : Int
    , maxHealth : Int
    , damage : Int
    }

newMonsterList : Int -> List Monster
newMonsterList n =
    (List.map newMonster <| List.range 1 n)

newMonster : Int -> Monster
newMonster n =
    { monsterId = n
    , maxHealth = 10
    , damage = 0
    }


model : Model
model =
    { monsterGroups =
        [ { monsterClass = "bandit", monsters = [ { monsterId = 1, maxHealth = 10, damage = 5 } ] }
        , { monsterClass = "ooze", monsters = [ { monsterId = 1, maxHealth = 10, damage = 5 }, { monsterId = 1, maxHealth = 10, damage = 5 } ] }
        ]
    }



-- UPDATE


type Msg
    = AddMonster



-- change


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddMonster ->
            { model | monsterGroups = model.monsterGroups ++ [ newMonsterGroup "MonsterB" 4] }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [onClick AddMonster ] [ text "Add" ]
        , div [ class "monsterGroups" ] (List.map monsterGroup model.monsterGroups)
        ]
    

monsterGroup : MonsterGroup -> Html Msg
monsterGroup monsterGroup =
    div [ class monsterGroup.monsterClass ] (List.map monster monsterGroup.monsters)


monster : Monster -> Html Msg
monster monster =
    div [ class "monster" ] []
