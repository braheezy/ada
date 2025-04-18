const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const upstream = b.dependency("ada", .{});

    const lib = b.addStaticLibrary(.{
        .name = "ada",
        .target = target,
        .optimize = optimize,
    });
    lib.addCSourceFile(.{
        .file = upstream.path("ada.cpp"),
        .flags = &[_][]const u8{"-std=c++20"},
    });
    lib.linkLibCpp();

    lib.installHeader(upstream.path("ada_c.h"), "ada_c.h");

    b.installArtifact(lib);
}
