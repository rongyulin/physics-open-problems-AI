# Leading torque tests for diagrams 94 and 88

**Chatgpt · Research note · 27 November 2026**

Consider the mass family with five entries equal to 1 and one entry equal to a positive parameter $t$. Diagram numbers and body labels below follow Table 1 of Tomar. A leading system gives necessary conditions at a singular place of a complex algebraic curve of six-body central configurations. A solution of the leading system still has to extend to a solution of the full six-body equations. [Tomar, Sections 2 and 6.7](https://hexagonmath.org/pdf/2611.00377v1)

## Diagram 94 admits an equilateral leading solution for every positive binary mass ratio

In Lemma 6.16(b), bodies 1, 2 and 3 surround body 4 in the four-body system $KC$. The binary has labels 5 and 6. Assume $m_1=m_2=m_3=1$ and take arbitrary $m_4,m_5,m_6>0$. Write $\omega=e^{2\pi i/3}$ and choose

$$
(X_1,X_2,X_3)=(1,\omega,\omega^2),\qquad
Y_l=R^2/X_l\quad(1\le l\le3),\qquad
X_4=Y_4=0,\qquad R^3=m_4+1/\sqrt3.
$$

Take the inverse distances $p_{l4}=1/R$ and $p_{lj}=1/(\sqrt3 R)$ for distinct $l,j\le3$. The assignment satisfies all the isolated four-body equations $N_4$, hence also $KC$. Indeed, each squared outer distance equals $3R^2$, each squared distance to the center equals $R^2$, and the sum of the three outer positions vanishes in each coordinate. In the force equation for outer body $l$, the two outer neighbors contribute $X_l/(\sqrt3 R^3)$ and the center contributes $m_4 X_l/R^3$. The same calculation applies to $Y_l$.

Lemma 6.17(b) gives the leading cross-cluster torque condition, with $\rho=(m_6/m_5)^{3/2}$ and $\beta_l=m_l/\sqrt{X_l}$. The relation $X_l^3=1$ allows the choice $\beta_l=X_l$. Taking all signs positive gives

$$
\sum_{l=1}^{3}\beta_l(1+i\rho)
=(1+i\rho)(1+\omega+\omega^2)=0.
$$

One can realize these signs in Lemma 6.16(b) by setting $\hat z_5=m_6$, $\hat z_6=-m_5$, $\hat p_{5l}=X_l/\sqrt{-m_6}$, and $\hat p_{6l}=i\sqrt{m_6/m_5}\,\hat p_{5l}$. Thus the displayed four-body, binary center-of-mass, cross-distance and torque equations all have compatible leading data.

On the five-equal line this construction applies when $t$ occupies label 4, 5 or 6. Assignments with $t$ among the outer three at $t\ne1$ require a separate analysis. The construction leaves open whether these data lift to an actual six-body place. In particular, the $z$-equation of body 4 at exponent 2 contains subleading terms from triangle $\{4,5,6\}$. The definition of $KC$ omits that coupled equation. The isolated four-body solution above cannot determine its six-body residual. [Tomar, Lemmas 6.16 and 6.17](https://hexagonmath.org/pdf/2611.00377v1)

A next test is to fix one admissible exponent cell and the rotation, restore the coupled body-4 equation, and expand the six-body equations around this solution. At the first order carrying a new compatibility condition, project the known forcing term onto the left nullspace of the linear equations for the new coefficients. A nonzero projection rules out that choice of cell and preceding coefficients. A graph-wide exclusion would also require control of the remaining cells, assignments, and leading solutions.

## The leading torque for the regular square in diagram 88 permits three binary mass ratios

Put $m_1=\dots=m_4=1$ and allow either binary mass to vary. In Lemma 6.16(a), consider the regular square solution of $N_4$. Index the four vertices by $k=0,1,2,3$ and put $\zeta=e^{\pi i/4}$, $X_k=\zeta^{-2k}$, $Y_k=R^2/X_k$. Choose $R^3=1/\sqrt2+1/4$. Each adjacent pair has distance $\sqrt2R$ and each opposite pair has distance $2R$. With positive internal inverse distances the four-body force equation holds, since the two neighboring vertices contribute $X_k/(\sqrt2 R^3)$ and the opposite vertex contributes $X_k/(4R^3)$, with the same formula for $Y_k$.

Equation (6.1), after summing first over the binary masses as in the proof of Lemma 6.17, requires $P+i\rho Q=0$. Here $P=\sum_{k=0}^3 a_k\zeta^k$, $Q=\sum_{k=0}^3 b_k\zeta^k$, and $a_k,b_k\in\{-1,1\}$ can be chosen independently for this equation. Indeed, $1/\sqrt{X_k}=\zeta^k$ for a choice of branches. A direct expansion gives

$$
|P|^2=4+\sqrt2\,[a_1(a_0+a_2)+a_3(a_2-a_0)]
\ \in\ \{4-2\sqrt2,4+2\sqrt2\}.
$$

The same holds for $Q$. Thus $P+i\rho Q=0$ implies $\rho=|P|/|Q|\in\{\sqrt2-1,1,\sqrt2+1\}$. Each value occurs in the torque equation. In order $k=0,1,2,3$, example sign vectors are

| $\rho$ | Signs of $a$ | Signs of $b$ |
| --- | --- | --- |
| $\sqrt2-1$ | `++-+` | `-+++` |
| $1$ | `++++` | `--++` |
| $\sqrt2+1$ | `++++` | `-+-+` |

With binary masses $1,t$, the regular square leading solution is therefore excluded except at $t=(\sqrt2-1)^{2/3},1,(\sqrt2+1)^{2/3}$. Interchanging the two binary masses gives the same set. This calculation concerns the regular square with the specified internal signs. Other complex four-body solutions and other placements of $t$ remain to be tested. At the three displayed values it establishes compatibility with the leading torque equation only. [Tomar, Lemmas 6.16(a) and 6.17](https://hexagonmath.org/pdf/2611.00377v1)

The Lean theorem `Diagram88Square.squareTorqueClassification` gives the equivalence for the two real torque coordinates and every positive $\rho$. The calculation identifying those coordinates with the physical square is above. [Lean source](../Lean/Diagram88Square.lean)
