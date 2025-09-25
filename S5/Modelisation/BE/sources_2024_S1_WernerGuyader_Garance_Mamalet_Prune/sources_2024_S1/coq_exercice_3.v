Section Session1_2024_Induction_Exercice_3.

Require Export Classical.

(* Définition du type inductif représentant les booléens *) 
Inductive booleen : Set :=
  Vrai : booleen
  | Faux : booleen.

(* Définition du type inductif représentant les entiers naturels *) 
Inductive naturel : Set :=
  Zero : naturel
  | Succ : naturel -> naturel.

(* Implantation de la fonction egal sur les entiers naturels *)
Fixpoint egal_impl (n1 n2 : naturel) {struct n1} : booleen :=
match (n1, n2) with
| (Zero, Zero) => Vrai
| (Zero, (Succ _)) => Faux
| ((Succ _), Zero) => Faux
| ((Succ p1), (Succ p2)) => (egal_impl p1 p2)
end.

(* Déclaration du nom de la fonction de comparaison *)
Definition egal_spec (n1 n2 : naturel) : Prop := (n1 = n2).

Axiom egal_correctness : forall (n1 n2 : naturel), 
  (((egal_impl n1 n2) = Vrai) -> (egal_spec n1 n2))
  /\
  (((egal_impl n1 n2) = Faux) -> (~ (egal_spec n1 n2))).

(* Déclaration du nom de la fonction somme *)
Variable somme_spec : naturel -> naturel -> naturel.

(* Spécification du comportement de somme pour Zero en premier paramètre *)
Axiom somme_Zero : forall (n : naturel), (somme_spec Zero n) = n.

Axiom somme_Zero_d : forall (n : naturel), (somme_spec n Zero) = n.

(* Spécification du comportement de somme pour Succ en premier paramètre *)
Axiom somme_Succ : forall (n m : naturel), (somme_spec (Succ n) m) = (Succ (somme_spec n m)).

(* Déclaration d’un domaine pour les éléments des listes *)
Variable E : Set.

(* Définition du type inductif représentant les listes d'éléments de E *) 
Inductive liste : Set :=
Nil : liste
| Cons : naturel -> liste -> liste.

(* Déclaration du nom de la fonction append *)
Variable append_spec : liste -> liste -> liste.

(* Spécification du comportement de append pour Nil en premier paramètre *)
Axiom append_Nil : forall (l : liste), append_spec Nil l = l.

(* Spécification du comportement de append pour Cons en premier paramètre *)
Axiom append_Cons : forall (t : naturel), forall (q l : liste),
   append_spec (Cons t q) l = Cons t (append_spec q l).

(* Déclaration du nom de la fonction rev *)
Variable rev_spec : liste -> liste.

(* Spécification du comportement de append pour Nil en premier paramètre *)
Axiom rev_Nil : rev_spec Nil = Nil.

(* Spécification du comportement de append pour Cons en premier paramètre *)
Axiom rev_Cons : forall (t : naturel), forall (q : liste),
   rev_spec (Cons t q) = (append_spec (rev_spec q) (Cons t Nil)).

(* Déclaration du nom de la fonction count *)
Variable count_spec : naturel -> liste -> naturel.

(* Spécification du comportement de count pour Nil en second paramètre *)
Axiom count_Nil : forall (v : naturel), count_spec v Nil = Zero.

(* Spécification du comportement de count pour Cons en second paramètre *)
Axiom count_Cons_egal : forall (t:naturel), forall (q: liste), count_spec t (Cons t q) = Succ (count_spec t q).

Axiom count_Cons_diff : forall (v : naturel), forall (t:naturel), forall(q:liste), count_spec v (Cons t q) = count_spec v q .

(* Permutation des variables quantifiées par rapport à l'examen pour simplifier la preuve *)
Theorem count_append : forall (l1 l2 : liste), forall (e : naturel),
  (count_spec e (append_spec l1 l2)) = (somme_spec (count_spec e l1) (count_spec e l2)).

intro l1.
intro l2.
intro e.
induction l1.
rewrite append_Nil.
rewrite count_Nil.
rewrite somme_Zero.
reflexivity.
rewrite append_Cons.
rewrite count_Cons_diff.
rewrite IHl1.
rewrite count_Cons_diff.
reflexivity.
Qed.

(* Permutation des variables quantifiées par rapport à l'examen pour simplifier la preuve *)
Theorem count_rev : forall (l : liste), forall (e : naturel),
  (count_spec e (rev_spec l)) = (count_spec e l).
intro l.
intro e.
induction l.
rewrite rev_Nil.
reflexivity.
rewrite rev_Cons.
rewrite count_append.
rewrite IHl.
rewrite count_Cons_diff.
rewrite count_Nil.
rewrite count_Cons_diff.
rewrite somme_Zero_d.
reflexivity.
Qed.

(* Implantation de la fonction count *)
Fixpoint count_impl (e : naturel) (l : liste) {struct l} : naturel :=
(* A COMPLETER *)
end.

(* Permutation des variables quantifiées par rapport à l'examen pour simplifier la preuve *)
Theorem count_correctness : forall (l : liste), forall (v : naturel),
   (count_spec v l) = (count_impl v l).
Proof.
(* A COMPLETER *)
Qed.



End Session1_2024_Induction_Exercice_3.
