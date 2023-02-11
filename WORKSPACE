workspace(name = "rules_latex_deps")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_foreign_cc",
    sha256 = "2a4d07cd64b0719b39a7c12218a3e507672b82a97b98c6a89d38565894cf7c51",
    strip_prefix = "rules_foreign_cc-0.9.0",
    url = "https://github.com/bazelbuild/rules_foreign_cc/archive/refs/tags/0.9.0.tar.gz",
)

_ALL_CONTENT = """\
filegroup(
    name = "all_srcs",
    srcs = glob(["**"]),
    visibility = ["//visibility:public"],
)
"""

http_archive(
    name = "ghost_script_source",
    sha256 = "6bf362286e359e31f934e5aad49db3d88a2382a3cac44b40572861ee5c536664",
    strip_prefix = "ghostpdl-9.56.1",
    build_file_content = _ALL_CONTENT,
    url = "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9561/ghostpdl-9.56.1.tar.gz",
)

http_archive(
    name = "dvisvgm_source",
    sha256 = "0bdcae37c23c9ab41c4261152912075edbbe798ddb2d06ba431af3e134ce18a6",
    strip_prefix = "dvisvgm-3.0.2",
    build_file_content = _ALL_CONTENT,
    url = "https://github.com/mgieseki/dvisvgm/releases/download/3.0.2/dvisvgm-3.0.2.tar.gz",
)
# Needed for building ghostscript
# Which is needed by dvisvgm,
# dvisvgm is part of the texlive toolchain,
# but cannot produce correct svg files without dynamically
# linking to ghostscript.
load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")

rules_foreign_cc_dependencies()