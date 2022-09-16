# Projet # 


**Groupe :** Antoine Chatelard, Marion Playout, Julien Poty.

## Sujet ##

Une entreprise pharmaceutique veut pouvoir réaliser ses tests sur une nouvelle molécule.
Toute personne autorisée (_approvals) et qui a le numéro de smartcontract peut ajouter des informations dans l'étude tant qu'elle n'est pas terminée.
Le contrat permet de renseigner : 
* l'identifiant du patient
* le numéro de lot du médicament testé
* un booléen si la molécule a fonctionné (true) ou pas (false)

La blockchain permet ici de garder : 
* une transparence des résultats
* une accessibilité des résultats à tout moment et à tout le réseau 

A la fin de l'étude, on empêche l'insertion de nouvelles données, le numéro de contrat permet d'avoir un certificat d'authenticité de l'étude pour le laboratoire qui l'a réalisée.  

On établit un nouveau contrat à chaque nouvelle étude de médicament.

[Lien du contrat](https://goerli.etherscan.io/address/0x08ee87b826a241bcfb4d270517075594d9eae85f)

Une base de front a été développé pour afficher le pourcentage d'efficacité du médicament et pour saisir de nouvelles données dans l'étude.
[Lien du repo react](https://github.com/a-chatelard/result-web3-app)

## Pistes d'optimisation (non développées) : ##

Un essai clinique a un nombre de "cobayes" défini.  
On pourrait limiter le nombre de résultats saisis au nombre de cobayes, une fois cette limite atteinte l'étude se clot automatiquement et on ne peut plus renseigner de nouvaux résultats.  

On pourrait présenter l'évolution dans résultats dans un graphe au fur et à mesure des entrées de données.
On pourrait aussi exporter l'intégralité des résultats pour réaliser les publications d'articles par exemple. 
