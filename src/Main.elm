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

newMonsterGroup : String -> Int -> Int -> MonsterGroup
newMonsterGroup class n health =
    { monsterClass = class
    , monsters = newMonsterList class n health
    }

type alias Monster =
    { monsterClass : String
    , monsterId : Int
    , maxHealth : Int
    , damage : Int
    }

newMonsterList : String -> Int -> Int -> List Monster
newMonsterList class n health =
    (List.map (newMonster class health) (List.range 1 n))

newMonster : String -> Int -> Int -> Monster
newMonster class health monsterId =
    { monsterClass = class
    , monsterId = monsterId
    , maxHealth = health
    , damage = 0
    }


model : Model
model =
    { monsterGroups =
        [ { monsterClass = "bandit", monsters = [ { monsterClass = "bandit", monsterId = 1, maxHealth = 10, damage = 5 } ] }
        , { monsterClass = "ooze", monsters = [ { monsterClass = "ooze", monsterId = 1, maxHealth = 10, damage = 5 }, { monsterClass = "ooze", monsterId = 2, maxHealth = 10, damage = 5 } ] }
        ]
    }



-- UPDATE


type Msg
    = AddMonster
    | IncrementDamage Monster
    | DecrementDamage Monster



-- change


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddMonster ->
            { model | monsterGroups = model.monsterGroups ++ [ newMonsterGroup "MonsterB" 4 7] }

        IncrementDamage existingMonster ->
            let
                updateMonsterGroup monsterGroup =
                    if monsterGroup.monsterClass == existingMonster.monsterClass then
                        { monsterGroup | monsters = List.map updateMonster monsterGroup.monsters }
                    else
                        monsterGroup

                updateMonster monster =
                    if monster.monsterId == existingMonster.monsterId then
                        { monster | damage = monster.damage + 1 }
                    else
                        monster

            in
                { model | monsterGroups = List.map updateMonsterGroup model.monsterGroups }

        DecrementDamage existingMonster ->
            let
                updateMonsterGroup monsterGroup =
                    if monsterGroup.monsterClass == existingMonster.monsterClass then
                        { monsterGroup | monsters = List.map updateMonster monsterGroup.monsters }
                    else
                        monsterGroup

                updateMonster monster =
                    if monster.monsterId == existingMonster.monsterId then
                        { monster | damage = monster.damage - 1 }
                    else
                        monster

            in
                { model | monsterGroups = List.map updateMonsterGroup model.monsterGroups }



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
    div [ class "monster" ]
        [ text ((toString monster.damage) ++ "/" ++ (toString monster.maxHealth))
        , button [ onClick (IncrementDamage monster) ] [ text "+" ]
        , button [ onClick (DecrementDamage monster) ] [ text "-"]
        ]
