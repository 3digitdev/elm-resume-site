module ResumePage.WorkHistory exposing (renderWorkHistoryPage)

import Html exposing (..)
import Html.Attributes exposing (..)
import ResumePage.Helpers exposing (..)
import ResumePage.Types exposing (Job, WorkHistoryPage)


renderWorkHistoryPage : WorkHistoryPage -> Html msg
renderWorkHistoryPage workPage =
    div [ id "Work" ]
        (workPage |> List.map renderJob)


renderJob : Job -> Html msg
renderJob job =
    div [ class "job row full-shadow" ]
        [ div [ class "four columns info-wrapper" ]
            [ span []
                [ h5 [ class "inline job-em" ] [ text "Employer: " ]
                , h6 [ class "job-info" ] [ text job.employer ]
                ]
            , span []
                [ h5 [ class "inline job-em" ] [ text "Dates: " ]
                , h6 [ class "job-info" ] [ text (formatStartEndDate job.startDate job.endDate) ]
                ]
            , span []
                [ h5 [ class "inline job-em" ] [ text "Title: " ]
                , h6 [ class "job-info" ] [ text job.title ]
                ]
            ]
        , div [ class "eight columns" ]
            [ ul [ class "job-resp" ]
                (renderInfoList job.info)
            ]
        ]
