# A finite projected-shape test for diagram 94

This note uses Tomar’s local labels from §6.7. The three outer bodies of the four-body cluster are $i=1,2,3$, the shared center is $c$, and the opposing pair has masses $M,N$. In the catalogue representative for diagram 94 these groups are, in zero-based labels, $\{1,2,3\}$, $5$, and $\{0,4\}$ respectively. The coordinates $X_i$ below are the large projection of the four-body cluster, translated so that $X_c=0$. The $X_i$ and their pairwise differences are nonzero. The reduction gives necessary tests on the remaining cases and supplies no additional row exclusions. [Tomar, Lemmas 6.16–6.17](https://hexagonmath.org/pdf/2611.00377v1)

Set $\rho=(N/M)^{3/2}$. Lemma 6.17 gives signs $\epsilon_i,s_i\in\{-1,1\}$ with $\sum_i v_i=0$, where $v_i=d_i m_i/\sqrt{X_i}$ and $d_i=\epsilon_i(1+i\rho s_i)$ (the $i$ multiplying $\rho$ is the imaginary unit). The centered four-body $X$ equations sum to $\sum_{i=1}^3m_i X_i=0$. Put $x=v_2/v_1$, so $v_3/v_1=-(1+x)$. Substituting $X_i=d_i^2m_i^2/v_i^2$ gives

$$
d_1^2m_1^3 x^2(1+x)^2+d_2^2m_2^3(1+x)^2+d_3^2m_3^3 x^2=0 .
$$

The leading coefficient is nonzero. Neither 0 nor $-1$ is a root. Each root gives a single candidate triple $X_1:X_2:X_3$ by the preceding ratios. In all 72 core-certified placements left in diagram 94, $M=N=1$. Thus $d_i^2=\pm2i$, and after dividing by $d_1^2$ there are only four sign patterns. There are at most sixteen candidate ratios before checking repeated shapes or zero pairwise differences. The same quartic reduction works for unequal positive binary masses with their corresponding values of $d_i$.

One can further restrict the conjugate projection without a general four-body elimination. Normalize $X_1=1$, write $p_*=p_{1c}\ne0$, put $r_i=p_{ic}/p_*$ with $r_1=1$, and let $q_{ij}=p_{ij}/p_*$. The central $X$-force and the six distance equations in the centered leading system imply

$$
m_1X_1+m_2X_2r_2^3+m_3X_3r_3^3=0,\qquad
Y_i-Y_c=\frac{1}{p_*^2 X_i r_i^2},
$$

$$
q_{ij}^2=\left[(X_i-X_j)
\left(\frac{1}{X_i r_i^2}-\frac{1}{X_j r_j^2}\right)\right]^{-1}.
$$

Exclude the zeros of every denominator as required by the six original distance equations. At each candidate $X$ the ratios $r_2,r_3$ lie on an explicit plane cubic. On its finite square-root cover the $X$ equation of body 1 fixes $p_*^{-3}$, because its left-hand side is $X_1=1$. The $Y$ equation of body 1 then fixes $Y_c$ using the displayed differences. Testing the other outer equations on this cover gives a smaller exact elimination problem. Any solution would still require extension to the six-body equations. The centered leading system omits one six-body equation carrying subleading terms.
