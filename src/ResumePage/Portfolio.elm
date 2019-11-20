module ResumePage.Portfolio exposing (renderPortfolioPage)

import Html exposing (..)
import Html.Attributes exposing (..)
import Ionicon as Ion
import ResumePage.Helpers exposing (..)
import ResumePage.Types exposing (PortfolioCard(..), PortfolioItem, PortfolioPage)


renderCardGroup : List PortfolioCard -> Html msg
renderCardGroup cardGroup =
    div [ class "folio-cards" ]
        (List.map
            (\card ->
                case card of
                    TextCard title items ->
                        div []
                            [ h6 [ class "folio-em center-text" ] [ text title ]
                            , ul [ class "folio-card" ] (renderInfoList items)
                            ]

                    ImageCard imgPath ->
                        div [ class "folio-image" ]
                            [ img [ src imgPath ] [] ]

                    LinkCard url txt ->
                        div [ class "center-text folio-link" ]
                            [ a [ href url ]
                                [ div []
                                    [ Ion.link 40 white
                                    , h3 [] [ text txt ]
                                    ]
                                ]
                            ]
            )
            cardGroup
        )


renderPortfolioItem : PortfolioItem -> Html msg
renderPortfolioItem item =
    div [ class "folio-item full-shadow" ]
        [ div []
            [ div
                [ class "folio-title center-text" ]
                [ h2 [] [ text item.title ] ]
            ]
        , renderCardGroup item.cards
        ]


renderPortfolioPage : PortfolioPage -> Html msg
renderPortfolioPage portfolioPage =
    div [ id "Portfolio" ]
        (case portfolioPage.items of
            [] ->
                [ emptyDiv ]

            items ->
                items |> List.map renderPortfolioItem
        )
