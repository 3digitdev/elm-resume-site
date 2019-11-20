module Resume exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Ionicon as Ion
import Ionicon.Ios as IonIos
import Ionicon.Social as IonSoc
import List.Extra exposing (greedyGroupsOf, last)
import Maybe.Extra exposing (unwrap)
import ResumePage.About exposing (..)
import ResumePage.Education exposing (..)
import ResumePage.Helpers exposing (..)
import ResumePage.Portfolio exposing (..)
import ResumePage.Skills exposing (..)
import ResumePage.Types exposing (..)
import ResumePage.WorkHistory exposing (..)


type alias Resume =
    { aboutPage : AboutPage
    , workHistoryPage : Maybe WorkHistoryPage
    , educationPage : Maybe EducationPage
    , skillsPage : Maybe SkillsPage
    , portfolioPage : Maybe PortfolioPage
    }


render : SelectedPage -> Resume -> Html msg
render curPage resume =
    div [ class "row content" ]
        [ div
            [ class "nine columns" ]
            [ curPage |> renderSelectedPage resume ]
        , div [ class "three columns" ] []
        ]


renderSelectedPage : Resume -> SelectedPage -> Html msg
renderSelectedPage resume selectedPage =
    case selectedPage of
        About ->
            resume.aboutPage |> renderAboutPage

        Work ->
            resume.workHistoryPage |> emptyDivOr renderWorkHistoryPage

        Education ->
            resume.educationPage |> emptyDivOr renderEducationPage

        Skills ->
            resume.skillsPage |> emptyDivOr renderSkillsPage

        Portfolio ->
            resume.portfolioPage |> emptyDivOr renderPortfolioPage
