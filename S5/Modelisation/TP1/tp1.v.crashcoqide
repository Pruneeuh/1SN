Require Import Naturelle.
Section LogiqueProposition.
Variable A B C E Y R : Prop.

Theorem Thm_0 : A /\ B -> B /\ A.
I_imp H.
I_et.
E_et_d A.
Hyp H.
E_et_g B.
Hyp H.
Qed.

Theorem Thm_1 : ((A \/ B) -> C) -> (B -> C).
I_imp H.
I_imp Hb.
E_imp(A \/ B).
Hyp H.
I_ou_d.
Hyp Hb.
Qed.

Theorem Thm_2 : A -> ~~A.
I_imp H.
I_non HnonA.
I_antiT(A).
Hyp H.
Hyp HnonA.
Qed.

Theorem Thm_3 : (A -> B) -> (~B -> ~A).
I_imp H. 
I_imp HnonA.
I_non Ha.
I_antiT(B).
E_imp(A).
Hyp H.
Hyp Ha.
Hyp HnonA.
Qed.

Theorem Thm_4 : (~~A) -> A.
I_imp Hnna.
absurde Ha.
I_antiT(~A).
Hyp Ha.
Hyp Hnna.


Qed.

Theorem Thm_5 : (~B -> ~A) -> (A -> B).
I_imp H.
I_imp Ha.
absurde Hnb.
I_antiT(A).
Hyp Ha.
E_imp(~B).
Hyp H.
Hyp Hnb.


Qed.

Theorem Thm_6 : ((E -> (Y \/ R)) /\ (Y -> R)) -> ~R -> ~E.
I_imp H.
I_imp Hnr.
I_non He.
E_non(R).
E_ou(Y)(R).
E_imp(E).
E_et_g(Y -> R).
Hyp H.
Hyp He.
E_et_d(E -> Y \/ R).
Hyp H.
I_imp Hr.
Hyp Hr.
Hyp Hnr.

Qed.

(* Version en Coq *)

Theorem Coq_Thm_0 : A /\ B -> B /\ A.
intro H.
destruct H as (HA,HB).  (* élimination conjonction *)
split.                  (* introduction conjonction *)
exact HB.               (* hypothèse *)
exact HA.               (* hypothèse *)
Qed.


Theorem Coq_E_imp : ((A -> B) /\ A) -> B.
intro H.
destruct H as (Haib,Ha).
cut(A).
exact Haib.
exact Ha.
Qed.

Theorem Coq_E_et_g : (A /\ B) -> A.
intro H.
destruct H as (Ha,Hb).
exact Ha.
Qed.

Theorem Coq_E_ou : ((A \/ B) /\ (A -> C) /\ (B -> C)) -> C.
intro H.
destruct H as (Hou,Himp).
destruct Himp as (Hac,Hbc).
destruct Hou as [Ha|Hb].
cut(A).
exact Hac.
exact Ha.
cut(B).
exact Hbc.
exact Hb.
Qed.

Theorem Coq_Thm_7 : ((E -> (Y \/ R)) /\ (Y -> R)) -> (~R -> ~E).
intro H.
destruct H as (H1,H2).
intro Hnr.
intro Hne.
absurd(R).
exact Hnr.
destruct H1.
exact Hne.
cut(Y).
exact H2.
exact H.
exact H.



Qed.

End LogiqueProposition.
