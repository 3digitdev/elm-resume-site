module ResumePage.Types exposing
    ( AboutPage
    , BootCamp
    , EducationPage
    , Email(..)
    , FormalEducation
    , Job
    , OtherEducation
    , PortfolioCard(..)
    , PortfolioItem
    , PortfolioPage
    , Skill
    , SkillsPage
    , SocialLink(..)
    , WorkHistoryPage
    )

import ResumePage.Helpers exposing (InfoItem)


type alias AboutPage =
    { avatar : Maybe String -- path to image.  recommend no bigger than 256px square
    , name : String -- Full name
    , city : Maybe String
    , stateOrProv : Maybe String -- State or Province
    , country : Maybe String
    , email : Maybe Email -- does not validate your email address, but will format text against scraping
    , socialLinks : List SocialLink
    , bio : List String -- A list of paragraphs for your bio.  List is rendered with gaps between paragraphs
    }


type Email
    = TextEmail String -- autoformats as  "foo (at) bar (dot) baz"
    | ImageEmail String -- recommended as best way to avoid web scrapers


type
    SocialLink
    -- each of these strings should be a URL to your profile
    = GitHub String
    | Twitter String
    | Facebook String
    | LinkedIn String
    | Website String


type alias WorkHistoryPage =
    List Job


type alias Job =
    { employer : String
    , startDate : String
    , endDate : String -- Can be empty string or "Present" and it will show as "Present"
    , title : String
    , info : List InfoItem -- Some info about what you did while in that job
    }


type alias EducationPage =
    { formalEducation : List FormalEducation
    , bootCamps : List BootCamp
    , otherEducation : OtherEducation
    }


type alias FormalEducation =
    -- Universities, Colleges, High School, etc
    { school : String
    , gradDate : String
    , degree : String
    , gpa : String
    , info : List InfoItem
    }


type alias BootCamp =
    -- Dev BootCamps or Code Camps
    { school : String
    , website : String
    , startDate : String
    , endDate : String
    , info : List InfoItem
    }


type alias OtherEducation =
    -- Self Education, Online courses, etc
    { notes : List InfoItem }


type alias SkillsPage =
    { skills : List Skill }


type alias Skill =
    { name : String
    , rating : Float -- float between 0.0 and 5.0 with 0.5 increments; displays as stars
    , blurb : String -- How have you or do you use this skill?  Have you used it in prod apps? Hobby language?
    }


type alias PortfolioPage =
    { items : List PortfolioItem }


type alias PortfolioItem =
    { title : String
    , cards : List PortfolioCard -- Multiple cards to display various info about the entry
    }


type PortfolioCard
    = TextCard String (List InfoItem) -- Pure text with title as <ul> with text or links
    | ImageCard String -- Just an image filling the card with capped width/height
    | LinkCard String String -- A card that has just a single link -- entire card is clickable
