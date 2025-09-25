Require Import Naturelle.
Section Session1_2020_Logique_Exercice_1.

Variable A B C : Prop.

Theorem Exercice_1_Naturelle :  ((A -> C) \/ (B -> C)) -> ((A /\ B) -> C).
Proof.
I_imp H.
I_imp H1.
E_ou(A->C)(B->C).
Hyp H.
I_imp H2.
E_imp(A).
Hyp H2.
E_et_g(B).
Hyp H1.
I_imp H2.
E_imp(B).
Hyp H2.
E_et_d(A).
Hyp H1.
Qed.

Theorem Exercice_1_Coq : ((A -> C) \/ (B -> C)) -> ((A /\ B) -> C).
Proof.
intros.
elim H.
intros.
cut A.
exact H1.
cut(A/\B).
intro H2.
elim H2.
intros.
exact H3.
exact H0.
intros.
cut B.
exact H1.
cut(A/\B).
intro H2.
elim H2.
intros.
exact H4.
exact H0.

Qed.

End Session1_2020_Logique_Exercice_1.

