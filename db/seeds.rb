# encoding: UTF-8
rubriques = Rubrique.create([
    {
        id: 1,
        title: %Q[LES COURS INDIVIDUELS],
        description: %Q[Basé au squash Club de St Cloud, Youssouf Mahamath, Professeur Diplomé d'Etat dispense des leçons de squash individuelles du lundi au dimanche]
    },
    {
        id: 2,
        title: %Q[LES COURS COLLECTIFS],
        description: %Q[Par groupe de 3 joueurs durant 1h00, nous abordons les mêmes notions qu'en séance individuelle, avec une orientation dès que possible vers le jeu.]
    },
    {
        id: 3,
        title: %Q[LES STAGES],
        description: %Q[Nous organisons régulièrement des stages durant les vacances avec un athlete de haut niveau ou à la retraite afin d'échanger, partager, et apprendre de leurs expériences de haut.],
        button_text: %Q[Le prochain stage],
        button_link: "/"
    },
    {
        id: 4,
        title: %Q[LE MINI-SQUASH & L'ECOLE DE SQUASH],
        description: %Q[J'accueille les enfants à partir de 4 ans pour jouer, s'initier et se familiariser au jeu du squash afin d'aller plus tard vers l'école de squash. Découvrir le sqash de manière ludique et éducative à travers de multiples ateliers et jeux sportifs.],
        button_text: %Q[La fiche d'inscription],
        button_link: "/"
    }
])

lecons_comments = LeconsComment.create([
    {
        id: 1,
        comment: %Q["Avant le début du stage, je n'avais jamais tenue une raquette. À la fin du stage, je prenais plaisir à jouer. Le format bien qu'intensif est idéal ppour découvrir ce sport dans une bonne ambiance et en petit comité. J'ai très envie de m'inscrire à une prochaine session pour progesser davantage. Merci à Youssouf pour sa patience et ses conseils !"],
        author: "Gwladys"
    },
    {
        id: 2,
        comment: %Q["Y a pas à dire, le patron est arrivé un beau matin de juillet sur les collines de St Cloud et nous avons bossé dur ! Quelle aubaine de prendre une leçon de squash avec Thierry LINCOU, ex-numéro 1 mondial multititré encore aujourd'hui. 
            Thierry est actuellement 8ème mondial, Champion d'Europe et de France 2009. Respect ! Ce stage de 3 jours  a été l'occasion de tout balayer : échauffements, renforcement musculaire, prises de raquette, plans de frappe, déplacement, stratégie, tactique, le mental et le coordination du tout... Ca piquait! 
            Heureusement, la diététique et les étirements complétaient ce programme étoffé."],
        author: "Fabrice Debus, licencié au club de Montigny, Stage à Montreuil Août 2013"
    },
    {
        id: 3,
        comment: %Q[“Un grand merci à mes élèves qui, en étant assidus  aux leçons, contribuent à m'améliorer et à transmettre un contenu de qualité à chaque séance.],
        author: "Youssouf Mahamat"
    }
    ])