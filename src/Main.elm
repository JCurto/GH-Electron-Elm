module Main exposing (..)

import Html exposing (Html, button, div, text, span, li, ul)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { groups : Int
    , monsterGroups : List MonsterGroup
    }


type alias MonsterGroup =
    { monsterClass : String
    , maxAllowed : Int
    , monsters : List Monster
    }


type alias Monster =
    { maxHealth : Int
    , damage : Int
    }


model : Model
model =
    { groups = 0
    , monsterGroups = [ { monsterClass = "bandit", maxAllowed = 6, monsters = [ { maxHealth = 10, damage = 5 } ] }
        , { monsterClass = "ooze", maxAllowed = 10, monsters = [ { maxHealth = 10, damage = 5 }, { maxHealth = 10, damage = 5 } ] } ]
    }



-- UPDATE


type Msg
    = Increment
    | Decrement

-- change
update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | groups = model.groups + 1 }

        Decrement ->
            { model | groups = model.groups - 1 }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ ul [ class "monsterGroups" ] (List.map monsterGroup model.monsterGroups)
        ]


monsterGroup : MonsterGroup -> Html Msg
monsterGroup monsterGroup =
    li [ class monsterGroup.monsterClass ]
        [ ul [ class "monsters" ] (List.map monster monsterGroup.monsters)
        ]


monster : Monster -> Html Msg
monster monster =
    li [ class "monster" ]
        [ div [ ] []
        ]
