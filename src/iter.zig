const cs = @import("capstone-c");

const Insn = @import("insn.zig").Insn;

const Handle = cs.csh;

pub const Iter = struct {
    handle: Handle,
    code: []const u8,
    address: u64,
    insn: [*]Insn,

    /// Consumes the iterator and goes to the next
    pub fn next(self: *Iter) ?*Insn {
        if (cs.cs_disasm_iter(self.handle, @ptrCast(&self.code.ptr), @ptrCast(&self.code.len), &self.address, @ptrCast(self.insn))) {
            return @ptrCast(self.insn);
        } else {
            return null;
        }
    }

    /// Clean up the iter
    pub fn deinit(self: Iter) void {
        cs.cs_free(@ptrCast(self.insn), 1);
    }

    /// Returns the current address
    pub fn address(self: Iter) u64 {
        return self.address;
    }
};
