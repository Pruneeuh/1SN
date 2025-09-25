Require Import Naturelle.
Section Session1_2019_Logique_Exercice_2.

Variable A B : Prop.


Theorem Exercice_2_Naturelle : (~A) \/ B -> (~A) \/ (A /\ B).
Proof.

I_imp H.
I_ou_d.
E_ou(~A)(B).
Hyp H.
I_imp H1.
I_et.



















I_imp H.
I_ou_d.
I_et.
E_ou(~A)(B).
Hyp H.
I_imp H2.
Qed.


Theorem Exercice_2_Coq : (~A) \/ B -> (~A) \/ (A /\ B).
Proof.




intro.
right.
cut A.
intro.
split.
Hyp H0.


elim H.
intro.

split.
Qed.

End Session1_2019_Logique_Exercice_2.

