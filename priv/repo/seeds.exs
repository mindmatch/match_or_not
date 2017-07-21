# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MatchOrNot.Repo.insert!(%MatchOrNot.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias MatchOrNot.Job
alias MatchOrNot.Talent
alias MatchOrNot.Score
alias MatchOrNot.Repo

job = Repo.insert!(%Job{
  description: Poison.decode!("""
{
  "job_title": "PHP Software Developer (m/f) ",
  "company_name": "Kyto",
  "para_1": "As a software developer at Kyto you are shaping a great software product with our team for our enterprise customers. We have many more ideas for new products, features and improvements and value a hands-on attitude to bring these ideas to life.",
  "para_2": "Kyto is a software as a service company located in Berlin and provides one-stop B2B online marketing solutions. We enable industrial enterprises to gain global reach and offer comprehensive support during the development of new sales markets. Thanks to our strong network of publishing partners we help our clients to take advantages of the internet and make their international deals easier, faster and more efficient.\nPHP Software Developer (m/f)\nYour potential workday:\n\nParticipating in the daily standup to discuss progress and facilitate team work\nWorking on a new feature using clean code and unit tests\nDeveloping improvements in our application for our operations team\nReviewing code of other developers and discussing improvements\nOptionally supporting with infrastructure tasks in our AWS environment\nGrabbing a beer with your colleagues after a successful and productive day\n\nYOUR ARGUMENTS\n\nExperiences as a developer\n(no need to have worked with all technologies listed above)\nGood English & communication skills\nFast learner\nPragmatism and the ability to understand the business and customer needs\nPassion for good code quality\n\nWHAT WE OFFER\nOur working mode:\n\nProfessional PHP 7 development using Symfony2 & 3\nQuerying and designing MySQL database efficiently\nSCRUM-based workflow with two-week sprints\nFor frontend developers: Transforming the front-end from Twig and jQuery to AngularJS\nFor automation developers: Automating tedious operational tasks with NodeJS\nMore technologies & tools: Docker, AWS, CodeShip, JIRA, Jenkins, Git, Grunt/Gulp, SASS, SonarQube, Nginx, Puppet, WordPress\n\nFurthermore:\n\nPermanent contract\nAttractive salary\nCoffee and Club Mate as much as you can drink\nRoom for your own ideas\nWorkplace in the heart of Berlin\nCollaborations with a smart team\n\nCONTACT\nChristin Urban\nHuman Resources Manager\nPhone: +49 (0) 30 994 040 111"
}
""")
})

job2 = Repo.insert!(%Job{
  description: Poison.decode!("""
{
  "job_title": "Ruby Software Developer",
  "company_name": "MindMatch",
  "para_1": "some js and",
  "para_2": "ruby ruby ruby"
}
""")
})

resume = Poison.decode!("""
{
"talent_id": 12716,
"summary": "<p>I am an experienced Software Developer.</p><ul>\n<li>8 years experience in PHP.<br>\n</li>\n<li>4 years experience using Symfony2.</li>\n<li>8 years experience in Javascript.<br>\n</li>\n<li>2 years experience using AngularJS 1.x.</li>\n</ul><p>Interested in both backend and frontend development.<br></p>",
"work_roles": [

],
"work_authorization": "yes",
"place": {
"label": "Berlin, Germany"
},
"roles": [
{
"role": "Frontend Engineer"
},
{
"role": "Fullstack Engineer"
},
{
"role": "PHP Engineer"
}
],
"salary_expectations": [
{
"currency": "EUR",
"city": "Berlin",
"minimum": 50000,
"maximum": 60000
},
{
"currency": "EUR",
"city": "Remote",
"minimum": 50000,
"maximum": 60000
}
],
"skills": [
{
"name": "Git"
},
{
"name": "Angular"
},
{
"name": "jQuery"
},
{
"name": "PHPUnit"
},
{
"name": "CSS"
},
{
"name": "PHP"
},
{
"name": "API"
},
{
"name": "Javascript"
},
{
"name": "Sass"
},
{
"name": "Symfony"
},
{
"name": "Behat"
},
{
"name": "XDebug"
}
],
"languages": [
{
"name": "english"
},
{
"name": "german"
},
{
"name": "spanish; castilian"
},
{
"name": "catalan; valencian"
}
],
"education_entries": {
"description": "University of Girona (Spain)",
"school": "Degree in Computer Management Engineering"
},
"experience_entries": [
{
"description": "Develop Software solutions using PHP5 (Symfony2) and Javascript (jQuery).\nSPA using AngularJS (frontend), with Symfony2 API (backend).\nImplement REST APIs using Symfony2 with OAuth2.\n",
"position": "Software developer",
"technologies": [

],
"start_year": 2013,
"end_year": 2015
},
{
"description": "Develop software solutions – Backend. (PHP5, MySQL).\nMobile programming (Phonegap + HTML5 + JS).\nWeb developing – Frontend (HTML4/5, CSS2/3, JS, JS/CSS libraries and frameworks).",
"position": "Web developer",
"technologies": [

],
"start_year": 2008,
"end_year": 2013
},
{
"description": "Develop backend new features and maintain B2B SaaS in PHP5/7 (Symfony2).\nAngularJS 1.X & jQuery in frontend.\nUnit and integration testing (PHPUnit). Behaviour testing (Behat).\n",
"position": "PHP Software Deveoloper",
"technologies": [

],
"start_year": 2015,
"end_year": null
}
]
}
""")

talent = Repo.insert!(%Talent{
  resume: resume
})

Repo.insert!(%Score{
  talent_id: talent.id,
  job_id: job.id,
  score: 0.07388845294
})

Repo.insert!(%Score{
  talent_id: talent.id,
  job_id: job2.id,
  score: 0.07788845294
})
