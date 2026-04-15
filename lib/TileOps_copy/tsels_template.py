"""TileLang DSL template for pto.tsels (select with scalar)"""

import sys
from pathlib import Path
import tilelang_dsl as pto


@pto.vkernel(
    target="a5",
    op="pto.tsels"
)
def template_tsels(mask: pto.Tile, src: pto.Tile, scalar, dst: pto.Tile):
    """Select between src and scalar based on mask.
    
    For each element:
    - if mask[i] != 0: dst[i] = src[i]
    - else: dst[i] = scalar
    """
    dtype = dst.element_type
    valid_rows, valid_cols = dst.valid_shape
    
    lanes = pto.get_lanes(dtype)
    scalar_vec = pto.vdup(scalar, dtype)
    
    for row in range(0, valid_rows, 1):
        remained = valid_cols
        for col in range(0, valid_cols, lanes):
            mask_val, remained = pto.make_mask(dtype, remained)
            mask_vec = pto.vlds(mask[row, col:])
            src_vec = pto.vlds(src[row, col:])
            selected = pto.vsel(src_vec, scalar_vec, mask_vec, mask_val)
            pto.vsts(selected, dst[row, col:], mask_val)
    return