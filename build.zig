const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const upstream = b.dependency("ada", .{});

    const lib_mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
    });
    lib_mod.addCSourceFile(.{
        .file = upstream.path("ada.cpp"),
        .flags = &[_][]const u8{"-std=c++20"},
    });
    const lib = b.addLibrary(.{
        .name = "ada",
        .root_module = lib_mod,
    });
    lib.linkLibCpp();

    lib.installHeader(upstream.path("ada_c.h"), "ada_c.h");

    b.installArtifact(lib);
}
