module ResumePage.About exposing (renderAboutPage)

import Html exposing (..)
import Html.Attributes exposing (..)
import Ionicon as Ion
import Ionicon.Ios as IonIos
import Ionicon.Social as IonSoc
import Maybe.Extra exposing (unwrap)
import ResumePage.Helpers exposing (..)
import ResumePage.Types exposing (AboutPage, Email(..), SocialLink(..))


renderAboutPage : AboutPage -> Html msg
renderAboutPage aboutPage =
    div [ id "About" ]
        (List.concat
            [ [ renderAvatar aboutPage.avatar
              , h2 [ class "about full-name" ] [ text aboutPage.name ]
              , renderLocation aboutPage
              , renderEmail aboutPage.email
              ]
            , renderSocial aboutPage.socialLinks
            , renderBio aboutPage.bio
            ]
        )


renderAvatar : Maybe String -> Html msg
renderAvatar avatarPath =
    avatarPath |> emptyDivOr (\a -> div [ class "avatar" ] [ img [ src a ] [] ])


renderLocation : AboutPage -> Html msg
renderLocation aboutPage =
    let
        city =
            aboutPage.city |> unwrap [] List.singleton

        stProv =
            aboutPage.stateOrProv |> unwrap [] List.singleton

        country =
            aboutPage.country |> unwrap [] List.singleton

        parsedText =
            List.concat [ city, stProv, country ]
                |> List.intersperse " 一 "
                |> String.join ""
    in
    if parsedText == "" then
        emptyDiv

    else
        h5 [ class "about" ] [ text parsedText ]


renderBio : List String -> List (Html msg)
renderBio paragraphs =
    case paragraphs of
        [] ->
            [ emptyDiv ]

        [ item ] ->
            [ hr [] []
            , div [ class "bio" ]
                [ h3 [ class "inline" ] [ text "Bio: " ]
                , p [ class "inline" ] [ text item ]
                ]
            ]

        first :: rest ->
            [ hr [] []
            , div
                [ class "bio" ]
                (List.concat
                    [ [ h3 [ class "inline" ] [ text "Bio: " ]
                      , p [ class "inline" ] [ text first ]
                      , p [] []
                      ]
                    , List.map (\item -> p [] [ text item ]) rest
                    ]
                )
            ]


socialToString : SocialLink -> String
socialToString socLink =
    case socLink of
        GitHub _ ->
            "GitHub"

        Twitter _ ->
            "Twitter"

        Facebook _ ->
            "Facebook"

        LinkedIn _ ->
            "LinkedIn"

        Website _ ->
            "Website"


renderSocial : List SocialLink -> List (Html msg)
renderSocial socialList =
    case socialList of
        [] ->
            [ emptyDiv ]

        socialLinks ->
            [ h3 [ class "about" ] [ text "Social:" ]
            , p
                [ class "about" ]
                (socialLinks
                    |> List.map renderSocialLink
                    |> List.intersperse (div [ class "inline spacer" ] [])
                )
            ]


renderSocialLink : SocialLink -> Html msg
renderSocialLink social =
    let
        ( icon, urlStr ) =
            case social of
                GitHub url ->
                    ( IonSoc.github, url )

                Twitter url ->
                    ( IonSoc.twitter, url )

                Facebook url ->
                    ( IonSoc.facebook, url )

                LinkedIn url ->
                    ( IonSoc.linkedin, url )

                Website url ->
                    ( IonIos.world, url )
    in
    a [ href urlStr, class "nav-link", title urlStr ]
        [ Html.form
            [ class "inline", action urlStr ]
            [ label
                [ for (String.toLower (socialToString social)), class "social inline" ]
                [ icon 32 white, text (socialToString social) ]
            , input
                -- TODO: Make id include index of item somehow
                [ id (String.toLower (socialToString social)), class "hidden inline", type_ "submit" ]
                []
            ]
        ]


renderEmail : Maybe Email -> Html msg
renderEmail maybeEmail =
    case maybeEmail of
        Nothing ->
            div [] []

        Just (TextEmail str) ->
            h4 [ class "about email" ] [ text str ]

        Just (ImageEmail imgPathStr) ->
            img [ class "about email", src imgPathStr ] [ text "email image" ]


formatEmailText : String -> String
formatEmailText email =
    email
        |> String.replace "@" " (at) "
        |> String.replace "." " (dot) "
