"""TileLang DSL template for pto.tadds"""

<<<<<<< HEAD
import tilelang_dsl as pto

=======
import sys
from pathlib import Path
import tilelang_dsl as pto


>>>>>>> 065e5981451af07cd09e8f422dea28d17fb4f33e
@pto.vkernel(
    target="a5",
    op="pto.tadds",
)
<<<<<<< HEAD
def template_tadds(dst: pto.Tile, src: pto.Tile, scalar: pto.AnyType):
=======
def template_tadds(src: pto.Tile, scalar: pto.AnyType, dst: pto.Tile):
>>>>>>> 065e5981451af07cd09e8f422dea28d17fb4f33e
    dtype = dst.element_type
    valid_rows, valid_cols = dst.valid_shape

    for row in range(0, valid_rows, 1):
        remained = valid_cols
        for col in range(0, valid_cols, pto.get_lanes(dtype)):
            mask, remained = pto.make_mask(dtype, remained)
            vec = pto.vlds(src[row, col:])
<<<<<<< HEAD
            summed = pto.vadds(vec, scalar, mask)
            pto.vsts(summed, dst[row, col:], mask)
=======
            result = pto.vadds(vec, scalar, mask)
            pto.vsts(result, dst[row, col:], mask)
>>>>>>> 065e5981451af07cd09e8f422dea28d17fb4f33e
    return
