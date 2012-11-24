SQRT2 = Math.sqrt(2)
SQRT3 = Math.sqrt(3)
TETRA_Q = SQRT2 / 3
TETRA_R = 1.0 / 3
TETRA_S = SQRT2 / SQRT3
TETRA_T = 2 * SQRT2 / 3
GOLDEN_MEAN = (Math.sqrt(5)+1)/2

PRIMITIVES = {
    :tetrahedron => {
        :points => {
            'a' => Vector[ -TETRA_S, -TETRA_Q, -TETRA_R ],
            'b' => Vector[ TETRA_S, -TETRA_Q, -TETRA_R ],
            'c' => Vector[ 0, TETRA_T, -TETRA_R ],
            'd' => Vector[ 0, 0, 1 ]
        },
    :faces => %w| acb abd adc dbc |
    },
    :octahedron => {
        :points => {
            'a' => Vector[ 0, 0, 1 ],
            'b' => Vector[ 1, 0, 0 ],
            'c' => Vector[ 0, -1, 0 ],
            'd' => Vector[ -1, 0, 0 ],
            'e' => Vector[ 0, 1, 0 ],
            'f' => Vector[ 0, 0, -1 ]
        },
        :faces => %w| cba dca eda bea
                      def ebf bcf cdf |
    },
    :icosahedron => {
        :points => {
            'a' => Vector[ 1, GOLDEN_MEAN, 0 ],
            'b' => Vector[ 1, -GOLDEN_MEAN, 0 ],
            'c' => Vector[ -1, -GOLDEN_MEAN, 0 ],
            'd' => Vector[ -1, GOLDEN_MEAN, 0 ],
            'e' => Vector[ GOLDEN_MEAN, 0, 1 ],
            'f' => Vector[ -GOLDEN_MEAN, 0, 1 ],
            'g' => Vector[ -GOLDEN_MEAN, 0, -1 ],
            'h' => Vector[ GOLDEN_MEAN, 0, -1 ],
            'i' => Vector[ 0, 1, GOLDEN_MEAN ],
            'j' => Vector[ 0, 1, -GOLDEN_MEAN ],
            'k' => Vector[ 0, -1, -GOLDEN_MEAN ],
            'l' => Vector[ 0, -1, GOLDEN_MEAN ]
        },
        :faces => %w| iea iad idf ifl ile
                      eha ajd dgf fcl lbe
                      ebh ahj djg fgc lcb
                      khb kjh kgj kcg kbc |
    }
}


