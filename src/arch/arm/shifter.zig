const Shift = @import("shift.zig").Shift;

pub const Shifter = extern union {
    type: Shift,
    value: c_uint,
};
