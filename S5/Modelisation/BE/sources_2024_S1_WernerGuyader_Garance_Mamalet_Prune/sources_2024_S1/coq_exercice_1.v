Require Import Naturelle.
Section Session1_2024_Logique_Exercice_1.

Variable A B : Prop.

Theorem Exercice_1_Naturelle :  ((A \/ (~B)) /\ B) -> A.
Proof.
I_imp H.
E_ou(A)(~B).
E_et_g(B).
Hyp H.
I_imp H1.
Hyp H1.
I_imp H2.
E_antiT.
I_antiT(B).
E_et_d(A \/ ~ B).
Hyp H.
Hyp H2.

Qed.

Theorem Exercice_1_Coq : ((A \/ (~B)) /\ B) -> A.
Proof.
intro.

elim H1.
destruct H1 as [H3|H4].
Hyp H3.


cut((A \/ ~ B) /\ B).

intro.
elim H.
intros.
destruct H1 as [H3|H4].
Hyp H3.


Qed.

End Session1_2024_Logique_Exercice_1.

