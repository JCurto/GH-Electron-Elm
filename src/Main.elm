module Main exposing (..)

import Html exposing (Html, button, div, text, span, li, ul)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import MonsterConfig exposing (getMonsterClassConfig, MonsterClassConfig)
import MonsterGroup exposing (MonsterGroup, Monster, newMonsterGroup)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { monsterGroups : List MonsterGroup
    }


model : Model
model =
    { monsterGroups = [] }



-- UPDATE


type Msg
    = AddOoze
    | AddBandit
    | IncrementDamage Monster
    | DecrementDamage Monster


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddOoze ->
            { model | monsterGroups = model.monsterGroups ++ [ newMonsterGroup (getMonsterClassConfig "Ooze") ] }

        AddBandit ->
            { model | monsterGroups = model.monsterGroups ++ [ newMonsterGroup (getMonsterClassConfig "Bandit") ] }

        IncrementDamage existingMonster ->
            let
                updateMonsterGroup monsterGroup =
                    if monsterGroup.class == existingMonster.class then
                        { monsterGroup | monsters = List.map updateMonster monsterGroup.monsters }
                    else
                        monsterGroup

                updateMonster monster =
                    if monster.monsterId == existingMonster.monsterId then
                        { monster | damageTaken = monster.damageTaken + 1 }
                    else
                        monster
            in
                { model | monsterGroups = List.map updateMonsterGroup model.monsterGroups }

        DecrementDamage existingMonster ->
            let
                updateMonsterGroup monsterGroup =
                    if monsterGroup.class == existingMonster.class then
                        { monsterGroup | monsters = List.map updateMonster monsterGroup.monsters }
                    else
                        monsterGroup

                updateMonster monster =
                    if monster.monsterId == existingMonster.monsterId then
                        { monster | damageTaken = monster.damageTaken - 1 }
                    else
                        monster
            in
                { model | monsterGroups = List.map updateMonsterGroup model.monsterGroups }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick AddOoze ] [ text "Add Ooze" ]
        , button [ onClick AddBandit ] [ text "Add Bandit" ]
        , div [ class "groups" ] (List.map monsterGroup model.monsterGroups)
        ]


monsterGroup : MonsterGroup -> Html Msg
monsterGroup monsterGroup =
    div [ class monsterGroup.class ] (List.map (\monsters -> monster monsterGroup monsters) monsterGroup.monsters)


monster : MonsterGroup -> Monster -> Html Msg
monster monsterGroup monster =
    div [ class "monster" ]
        [ span [] [ text ("Name: " ++ monster.class ++ "[" ++ (toString monster.monsterId) ++ "] ") ]
        , span [] [ text ("H: " ++ (toString (monster.maxHealth - monster.damageTaken)) ++ "/" ++ (toString monster.maxHealth) ++ " ") ]
        , span [] [ text ("M: " ++ (toString monsterGroup.movement) ++ " ") ]
        , span [] [ text ("D: " ++ (toString monsterGroup.damage) ++ " ") ]
        , span [] [ text ("R: " ++ (toString monsterGroup.range) ++ " ") ]
        , button [ onClick (IncrementDamage monster) ] [ text "+" ]
        , button [ onClick (DecrementDamage monster) ] [ text "-" ]
        ]
