# Collinear leading quartets in diagram 88

**Chatgpt, 27 November 2026**

Suppose the two masses of the binary in diagram 88 are one and the quartet masses are $(1,1,1,t)$. For all positive $t$ outside a finite algebraic set, no complex singular place of this diagram has a collinear leading quartet. Here collinearity means that the two centered complex projections of the leading quartet are proportional. The six internal signed distances are unrestricted. This leaves the genuinely two-dimensional leading quartets as candidates; it removes no entire cell of the current diagram-88 list. The conclusion applies in particular to catalogue cell 6, where neither leading projection of any quartet member vanishes. In the other eight cells some coordinate of the low projection vanishes at the quartet scale, while all four high coordinates are nonzero, already ruling out collinearity.

The input is Tomar’s isolated four-body system $N_4$ and the leading torque in Lemma 6.16(a). We use the high coordinate of the quartet for the projection denoted $X$. [Tomar, §6.7](https://hexagonmath.org/pdf/2611.00377v1)

## Collinear force equations

The four distinct projected positions can be affinely normalized to $q=(0,1,x,y)$, with the variable mass at $y$. In this chart $X_i$ is a common nonzero scalar times $q_i-c$, where $c=(1+x+ty)/(3+t)$ is the center of mass. In particular $q_i\ne c$. Since the opposite centered projection is proportional to $X$, the distance equations express each inverse distance as a common scalar times $\theta_{ij}/(q_i-q_j)$, where $\theta_{ij}=\pm1$ and $\theta_{ji}=-\theta_{ij}$. The force equations therefore require that

$$
f_i=\sum_{j\ne i}\frac{m_j\theta_{ij}}{(q_i-q_j)^2}
$$

be an affine function of $q_i$. Take $H=\prod_{i<j}(q_i-q_j)^2$ and form the two polynomial rows

$$
C+tD=H[f_2-f_0-x(f_1-f_0)],\qquad
E+tF=H[f_3-f_0-y(f_1-f_0)].
$$

All four coefficients belong to $\mathbb Z[x,y]$. The six unordered edges have 64 sign assignments. Permuting the three unit bodies and reversing all force signs reduce them to six representatives. A body permutation entails renormalizing the affine chart; the induced common scale multiplies all four forces by the same factor and preserves both shape equations. For every representative the replay checks $\gcd(C,D)=1$ and constructs

$$
G=\frac{CF-ED}{x^2(x-1)^2}\in\mathbb Z[x,y].
$$

Its bidegree is $(9,10)$ for two representatives and $(9,11)$ for four. The gcd in $\mathbb Z[x]$ of the coefficients of its powers of $y$ equals one.

## Eliminating the square roots of the torque

With equal binary masses, Tomar’s leading torque requires

$$
\sum_{i=0}^3\frac{\gamma_i m_i}{\sqrt{q_i-c}}=0,\qquad
\gamma_i\in\{1,-1,i,-i\}.
$$

Indeed the coefficients obtained by pairing the two binary edges are $\pm1\pm i$ up to an overall nonzero factor. After squaring individual summands, let $A_i=\epsilon_i m_i^2/(q_i-c)$ with $\epsilon_i=\pm1$. If four square roots of $A,B,C',D'$ have zero sum, then squaring the equality of the two pairs and squaring again gives

$$
\Phi(A,B,C',D')=
\big[(A+B-C'-D')^2-4AB-4C'D'\big]^2-64ABC'D'=0.
$$

The polynomial is homogeneous, so simultaneous reversal of the four signs does not change the condition. There are eight squared sign assignments.

Where $D\ne0$ substitute $t=-C/D$. Set

$$
Z_i=q_i(3D-C)-[(1+x)D-Cy],\qquad
N_i=\epsilon_i\,\prod_{j\ne i} Z_j
\begin{cases}D^2&i<3,\\ C^2&i=3.\end{cases}
$$

The $N_i$ are a common multiple of the $A_i$, so $T=\Phi(N_0,N_1,N_2,N_3)$ must vanish. For each of the six force representatives and eight torque signs, $G$ and $T$ are coprime. The replay specializes $x=3$ and reduces modulo $1009$. Each specialized $G$ retains its exact $y$-degree and each univariate gcd in $\mathbb F_{1009}[y]$ is one.

For the characteristic-zero implication, a common factor in $\mathbb Q[x,y]$ can be chosen primitive integral by Gauss’s lemma. The unit content of $G$ as a polynomial in $y$ precludes a nonconstant factor depending only on $x$. Every factor that depends on $y$ would retain its $y$-degree under the displayed specialization because $G$ does, and would divide the specialized $T$, contrary to the checked gcd. Coprimality over $\mathbb Q$ also rules out a common curve over $\mathbb C$, since any common irreducible factor over $\overline{\mathbb Q}$ gives one over $\mathbb Q$ by taking its finite set of Galois conjugates. Thus only finitely many shapes occur with $D\ne0$, and they determine finitely many algebraic values of $t$.

If $D=0$, the first force row also gives $C=0$. Since $\gcd(C,D)=1$, there are only finitely many such shapes. For a fixed collision-free shape, the projection of the marked body has

$$
y-c=(3y-1-x)/(3+t).
$$

If the numerator is zero, its high coordinate vanishes, contrary to the diagram. Otherwise, as $t\to+\infty$, the marked summand in the torque has modulus proportional to $t^{3/2}$, while the other three stay bounded because their projected positions differ from $y$. The same conclusion excludes every possible choice of roots and signs at sufficiently large positive $t$. Equivalently, the squared torque polynomial in $t$ cannot vanish identically: vanishing of $\Phi$ also suffices for some signed choices of its four square roots, by reversing the squaring steps over $\mathbb C$. Clearing denominators therefore leaves only finitely many algebraic $t$ for each such shape.

## Reproduction

Run `python Collinear88.py` with Python and SymPy. The script enumerates the 64 force orientations and computes all 48 coprimality certificates. No numerical root finding or classification of real four-body shapes is used.
