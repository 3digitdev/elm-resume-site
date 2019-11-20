module ResumePage.Education exposing (renderEducationPage)

import Html exposing (..)
import Html.Attributes exposing (..)
import ResumePage.Helpers exposing (..)
import ResumePage.Types exposing (BootCamp, EducationPage, FormalEducation, OtherEducation)


renderFormalEducation : FormalEducation -> Html msg
renderFormalEducation formalEducation =
    div [ class "education row full-shadow" ]
        [ div [ class "four columns info-wrapper" ]
            [ span []
                [ h5 [ class "inline ed-em" ] [ text "School: " ]
                , h6 [ class "ed-info" ] [ text formalEducation.school ]
                ]
            , span []
                [ h5 [ class "inline ed-em" ] [ text "Graduated: " ]
                , h6 [ class "ed-info" ] [ text formalEducation.gradDate ]
                ]
            , span []
                [ h5 [ class "inline ed-em" ] [ text "Degree: " ]
                , h6 [ class "ed-info" ] [ text formalEducation.degree ]
                ]
            , span []
                [ h5 [ class "inline ed-em" ] [ text "GPA: " ]
                , h6 [ class "inline ed-em" ] [ text formalEducation.gpa ]
                ]
            ]
        , div [ class "eight columns" ]
            [ ul [ class "ed-resp" ] (renderInfoList formalEducation.info) ]
        ]


renderOtherEducation : List InfoItem -> Html msg
renderOtherEducation otherEducation =
    div [ class "education row full-shadow" ]
        [ div [ class "four columns info-wrapper" ]
            [ span []
                [ h5 [ class "inline ed-em" ] [ text "Other/Self Education" ]
                ]
            ]
        , div [ class "eight columns ed-resp" ]
            [ ul [ class "ed-resp" ] (renderInfoList otherEducation) ]
        ]


renderBootCamp : BootCamp -> Html msg
renderBootCamp bootCamp =
    div [ class "education row full-shadow" ]
        [ div [ class "four columns info-wrapper" ]
            [ span []
                [ h5 [ class "inline ed-em" ] [ text "School: " ]
                , h6 [ class "ed-info" ] [ a [ href bootCamp.website ] [ text bootCamp.school ] ]
                ]
            , span []
                [ h5 [ class "inline ed-em" ] [ text "Attendance: " ]
                , h6 [ class "ed-info" ] [ text (formatStartEndDate bootCamp.startDate bootCamp.endDate) ]
                ]
            ]
        , div [ class "eight columns ed-resp" ]
            [ ul [ class "ed-resp" ] (renderInfoList bootCamp.info) ]
        ]


renderEducationPage : EducationPage -> Html msg
renderEducationPage eduPage =
    let
        formalEdDom =
            case eduPage.formalEducation of
                [] ->
                    [ emptyDiv ]

                formalEds ->
                    formalEds |> List.map renderFormalEducation

        bootCampsDom =
            case eduPage.bootCamps of
                [] ->
                    [ emptyDiv ]

                bootCamps ->
                    bootCamps |> List.map renderBootCamp

        otherEdDom =
            case eduPage.otherEducation.notes of
                [] ->
                    [ emptyDiv ]

                otherEd ->
                    [ otherEd |> renderOtherEducation ]
    in
    div [ id "Education" ]
        (List.concat [ formalEdDom, bootCampsDom, otherEdDom ])
