Require Import Naturelle.
Section Session1_2019_Logique_Exercice_1.

Variable A B C : Prop.

Theorem Exercice_1_Coq :  (A -> B -> C) -> ((A /\ B) -> C).
Proof.
intro.
intro.
elim H0.
exact H.
Qed.

Theorem Exercice_1_Naturelle :  (A -> B -> C) -> ((A /\ B) -> C).
Proof.
I_imp H.
I_imp H1.
E_ou(A)(B).
I_ou_g.
E_et_g(B).
Hyp H1.
I_imp H2.
E_imp(B).
E_imp(A).
Hyp H.
Hyp H2.
E_et_d(A).
Hyp H1.
E_imp(A).
Hyp H.
E_et_g(B).
Hyp H1.

Qed.

End Session1_2019_Logique_Exercice_1.

