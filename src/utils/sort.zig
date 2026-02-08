const std = @import("std");
const Type = @import("../ast/type.zig").Type;
const FieldDefinition = @import("../ast/field_definition.zig").FieldDefinition;
const InputValueDefinition = @import("../ast/input_value_definition.zig").InputValueDefinition;
const ExecutableDefinition = @import("../ast/executable_definition.zig").ExecutableDefinition;

pub fn namedTypeLessThan(_: void, a: Type, b: Type) bool {
    switch (a) {
        .namedType => |aNamedType| {
            switch (b) {
                .namedType => |bNamedType| return std.mem.order(u8, aNamedType.name, bNamedType.name) == .lt,
                else => return false,
            }
        },
        else => return false,
    }
}

pub fn fieldDefinitionLessThan(_: void, a: FieldDefinition, b: FieldDefinition) bool {
    return std.mem.order(u8, a.name, b.name) == .lt;
}

pub fn inputValueDefinitionLessThan(_: void, a: InputValueDefinition, b: InputValueDefinition) bool {
    return std.mem.order(u8, a.name, b.name) == .lt;
}

pub fn executableDefinitionLessThan(_: void, a: ExecutableDefinition, b: ExecutableDefinition) bool {
    switch (a) {
        .schemaDefinition => {
            return true;
        },
        .objectTypeDefinition => |aObjectTypeDefinition| {
            switch (b) {
                .schemaDefinition => return false,
                .objectTypeDefinition => |bObjectTypeDefinition| {
                    return std.mem.order(u8, aObjectTypeDefinition.name, bObjectTypeDefinition.name) == .lt;
                },
                else => return true,
            }
        },
        .inputObjectTypeDefinition => |aInputObjectTypeDefinition| {
            switch (b) {
                .schemaDefinition => return false,
                .objectTypeDefinition => return false,
                .inputObjectTypeDefinition => |bInputObjectTypeDefinition| {
                    return std.mem.order(u8, aInputObjectTypeDefinition.name, bInputObjectTypeDefinition.name) == .lt;
                },
                else => return true,
            }
        },
        .interfaceTypeDefinition => |aInterfaceTypeDefinition| {
            switch (b) {
                .schemaDefinition => return false,
                .objectTypeDefinition => return false,
                .inputObjectTypeDefinition => return false,
                .interfaceTypeDefinition => |bInterfaceTypeDefinition| {
                    return std.mem.order(u8, aInterfaceTypeDefinition.name, bInterfaceTypeDefinition.name) == .lt;
                },

                else => return true,
            }
        },
        .unionTypeDefinition => |aUnionTypeDefinition| {
            switch (b) {
                .schemaDefinition => return false,
                .objectTypeDefinition => return false,
                .inputObjectTypeDefinition => return false,
                .interfaceTypeDefinition => return false,
                .unionTypeDefinition => |bUnionTypeDefinition| {
                    return std.mem.order(u8, aUnionTypeDefinition.name, bUnionTypeDefinition.name) == .lt;
                },
                else => return true,
            }
        },
        .scalarTypeDefinition => |aScalarTypeDefinition| {
            switch (b) {
                .schemaDefinition => return false,
                .objectTypeDefinition => return false,
                .inputObjectTypeDefinition => return false,
                .interfaceTypeDefinition => return false,
                .unionTypeDefinition => return false,
                .scalarTypeDefinition => |bScalarTypeDefinition| {
                    return std.mem.order(u8, aScalarTypeDefinition.name, bScalarTypeDefinition.name) == .lt;
                },
                else => return true,
            }
        },
        .directiveDefinition => |aDirectiveDefinition| {
            switch (b) {
                .schemaDefinition => return false,
                .objectTypeDefinition => return false,
                .inputObjectTypeDefinition => return false,
                .interfaceTypeDefinition => return false,
                .unionTypeDefinition => return false,
                .scalarTypeDefinition => return false,
                .directiveDefinition => |bDirectiveDefinition| {
                    return std.mem.order(u8, aDirectiveDefinition.name, bDirectiveDefinition.name) == .lt;
                },
                else => return true,
            }
        },
        .enumTypeDefinition => |aEnumTypeDefinition| {
            switch (b) {
                .schemaDefinition => return false,
                .objectTypeDefinition => return false,
                .inputObjectTypeDefinition => return false,
                .interfaceTypeDefinition => return false,
                .unionTypeDefinition => return false,
                .scalarTypeDefinition => return false,
                .directiveDefinition => return false,
                .enumTypeDefinition => |bEnumTypeDefinition| {
                    return std.mem.order(u8, aEnumTypeDefinition.name, bEnumTypeDefinition.name) == .lt;
                },
                else => return true,
            }
        },
        else => return true,
    }
}
