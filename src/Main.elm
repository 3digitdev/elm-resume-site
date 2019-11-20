module Main exposing
    ( Model
    , Msg(..)
    , init
    , main
    , subscriptions
    , update
    , view
    )

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Maybe.Extra exposing (unwrap)
import Resume exposing (Resume)
import ResumePage.Helpers exposing (..)
import ResumePage.Types exposing (..)
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- RESUME DEFINITION


sampleResume : Resume
sampleResume =
    Resume
        sampleAboutPage
        sampleWorkHistory
        sampleEducationPage
        sampleSkillsPage
        samplePortfolioPage


sampleAboutPage : AboutPage
sampleAboutPage =
    { avatar = Just "sampleAvatar.png"
    , name = "Sample User With Long Name"
    , city = Just "Hometown"
    , stateOrProv = Just "Massachusetts"
    , country = Just "USA"
    , email = Just (ImageEmail "sampleEmail.png") -- try using    Just (TextEmail "some.sample@email.com")
    , socialLinks =
        [ GitHub "https://github.com/"
        , Twitter "https://www.twitter.com/"
        , Facebook "https://www.facebook.com/"
        , LinkedIn "https://www.linkedin.com/"
        , Website "https://www.google.com/"
        ]
    , bio =
        [ "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        , "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        , "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        ]
    }


sampleWorkHistory : Maybe WorkHistoryPage
sampleWorkHistory =
    Just
        [ Job
            "Google"
            "May 2016"
            "Present"
            "Software Engineer"
            [ TextItem "Invented Google Wave"
            , TextItem "Worked on the team that made Google Reader"
            , TextItem "Did some other awesome stuff"
            ]
        , Job
            "Tech Solutions Consultants, LLC."
            "February 2014"
            "March 2016"
            "Integrated Solutions Consultant"
            [ TextItem "Helped to create custom solutions for clients"
            , LinkItem "https://www.google.com/search?q=integrated+solutions" "Sample Solutions"
            , TextItem "Helped integrate our proprietary software into user's daily lives"
            , TextItem "Worked a lot with C#"
            ]
        , Job
            "Hometown Website Shop"
            "May 2012"
            "August 2012"
            "Software Intern"
            [ TextItem "Worked as a summer intern on updating and managing websites for local businesses"
            , TextItem "Got to oversee and take the lead on local hardware store's website"
            , LinkItem "https://www.acehardware.com/" "Ace Hardware"
            ]
        ]


sampleEducationPage : Maybe EducationPage
sampleEducationPage =
    Just
        { formalEducation =
            [ FormalEducation
                "M.I.T."
                "May 2013"
                "B.S. Computer Science"
                "3.5"
                [ TextItem "Took courses in several languages including Java, Python, and C++"
                , TextItem "Lerned Object Oriented Programming and similar concepts"
                , TextItem "Capstone project was building a Sudoku Solver and competing in a speed competition with it (got 2nd place)"
                ]
            ]
        , bootCamps =
            [ BootCamp
                "DevCodeCamp"
                "https://devcodecamp.com/"
                "August 2013"
                "February 2014"
                [ TextItem "Took a code camp to learn frontend development in React, JavaScript, and HTML/CSS"
                , TextItem "Learned about Git, CI/CD pipelines, and many other things"
                , TextItem "Looked into but didn't do much with Redux and VueJS as well"
                , LinkItem "https://www.github.com/" "Link to my GitHub repo"
                ]
            ]
        , otherEducation =
            OtherEducation
                [ TextItem "Took some online courses at Udemy on JS and web technologies"
                , TextItem "Studied new languages on my own time like Elm (♥)"
                , TextItem "Participated in Code Colf and Euler Project to learn more"
                , TextItem "Did the Advent of Code in 2013 using Python"
                , LinkItem "https://www.github.com/" "My Repo for AoC (Python)"
                ]
        }


sampleSkillsPage : Maybe SkillsPage
sampleSkillsPage =
    Just
        { skills =
            [ Skill "Python" 3.5 "Primary hobby language, no industry experience"
            , Skill "Elm" 2.0 "Current hobby web language"
            , Skill "React" 3.0 "Learned and used extensively in Code Camp, used to develop production apps"
            , Skill "Git" 3.5 "Used extensively and have learned a lot about various obscure commands"
            , Skill "Java" 2.0 "Haven't used much since college but still remember most of what I learned"
            , Skill "JavaScript" 3.5 "Heavily used in industry experience, including production apps"
            , Skill "C++" 1.5 "Learned the basics in college but haven't used since then"
            , Skill "C#" 3.5 "Heavily used in industry experience, including several production apps"
            , Skill "Regex" 1.5 "Learned about this during Code Golf -- Looks amazing, still learning"
            ]
        }


samplePortfolioPage : Maybe PortfolioPage
samplePortfolioPage =
    Just
        { items =
            [ PortfolioItem
                "Client Website"
                [ LinkCard "https://www.samplewebsite.com/" "Link to site"
                , TextCard "Description"
                    [ TextItem "Helped build this website from scratch"
                    , TextItem "Worked closely with the client to determine their needs"
                    , TextItem "Used web best practices to make the site fast and responsively designed"
                    , TextItem "Fully A11Y compliant!"
                    ]
                , ImageCard "sampleWebsiteImage.png"
                , TextCard "Tech Stack"
                    [ TextItem "Backend is NodeJS for their shopping portal"
                    , LinkItem "https://nodejs.org" "NodeJS"
                    , TextItem "Database is SQLite"
                    , TextItem "Frontend is in React based on Material Design CSS"
                    , LinkItem "https://reactjs.org/" "ReactJS"
                    , LinkItem "https://material.io/" "Material Design CSS"
                    ]
                ]
            ]
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , page : SelectedPage
    , resume : Resume
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( initModel url key, Cmd.none )


initModel : Url.Url -> Nav.Key -> Model
initModel url key =
    { key = key
    , url = url
    , page = About
    , resume = sampleResume
    }



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NavClicked SelectedPage -- Absolutely necessary for Navigation Bar to work


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            let
                page =
                    urlToPage url.path
            in
            ( { model | url = url, page = page }, Cmd.none )

        NavClicked page ->
            ( { model | page = page }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = pageString model.page
    , body =
        [ div
            [ class "container" ]
            [ div [ class "row" ]
                [ div
                    [ class "nine columns center-text" ]
                    [ h1 [] [ span [ class "page-header" ] [ text (pageString model.page) ] ] ]
                ]
            , renderNavBar model.resume model.page
            , model.resume |> Resume.render model.page
            ]
        ]
    }


renderNavBar : Resume -> SelectedPage -> Html Msg
renderNavBar resume curPage =
    let
        -- figure out what pages the user is including in the resume, only render those
        validPages =
            List.concat
                [ [ About ]
                , resume.workHistoryPage |> unwrap [] (\_ -> List.singleton Work)
                , resume.educationPage |> unwrap [] (\_ -> List.singleton Education)
                , resume.skillsPage |> unwrap [] (\_ -> List.singleton Skills)
                , resume.portfolioPage |> unwrap [] (\_ -> List.singleton Portfolio)
                ]
    in
    div [ class "three columns nav-bar full-shadow" ]
        (validPages |> List.map (navLink curPage))


navLink : SelectedPage -> SelectedPage -> Html Msg
navLink curPage renderPage =
    let
        navClass =
            if renderPage == curPage then
                "nav current"

            else
                "nav"
    in
    a
        [ class "nav-link"
        , href (pageLink renderPage)
        , onClick (NavClicked renderPage)
        ]
        [ h4
            [ class navClass ]
            [ pageIcon renderPage white, text (pageString renderPage) ]
        ]
