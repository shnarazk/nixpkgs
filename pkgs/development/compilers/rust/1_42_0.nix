# New rust versions should first go to staging.
# Things to check after updating:
# 1. Rustc should produce rust binaries on x86_64-linux, aarch64-linux and x86_64-darwin:
#    i.e. nix-shell -p fd or @GrahamcOfBorg build fd on github
#    This testing can be also done by other volunteers as part of the pull
#    request review, in case platforms cannot be covered.
# 2. The LLVM version used for building should match with rust upstream.
# 3. Firefox and Thunderbird should still build on x86_64-linux.

{ stdenv, lib
, buildPackages
, newScope, callPackage
, CoreFoundation, Security
, llvmPackages_5
, pkgsBuildTarget, pkgsBuildBuild
, fetchpatch
} @ args:

import ./default.nix {
  rustcVersion = "1.42.0";
  rustcSha256 = "0x9lxs82may6c0iln0b908cxyn1cv7h03n5cmbx3j1bas4qzks6j";

  # Note: the version MUST be one version prior to the version we're
  # building
  bootstrapVersion = "1.41.1";

  # fetch hashes by running `print-hashes.sh 1.41.1`
  bootstrapHashes = {
    i686-unknown-linux-gnu = "085c8880ee635c2182504a1f2aaa2865455f9ff43511b3976a2140a8bfcce6f3";
    x86_64-unknown-linux-gnu = "a6d5a3b3f574aafc8f787fea37aad9fb8a7946b383ae5348146927192ff0bef0";
    arm-unknown-linux-gnueabihf = "210090e13970646707325fc0270ef368cde3e2a4a7671f2cf374f57fcc8e3770";
    armv7-unknown-linux-gnueabihf = "531e4006fee503ba1581c3feca2932f99d0df97bc2361e33fa028e3d7060ccc1";
    aarch64-unknown-linux-gnu = "d54c0f9165b86216b6f1b499f451141407939c5dc6b36c89a3772895a1370242";
    i686-apple-darwin = "727cbbfa58a2698d577c99f2a221512bff6ba07ca98ec47cf7ec5043eca60c81";
    x86_64-apple-darwin = "16615288cf74239783de1b435d329f3d56ed13803c7c10cd4b207d7c8ffa8f67";
  };

  selectRustPackage = pkgs: pkgs.rust_1_42_0;

#  rustcPatches = [
#    (fetchpatch {
#      url = "https://github.com/QuiltOS/rust/commit/f1803452b9e95bfdbc3b8763138b9f92c7d12b46.diff";
#      sha256 = "1mzxaj46bq7ll617wg0mqnbnwr1da3hd4pbap8bjwhs3kfqnr7kk";
#    })
#  ];
}

(builtins.removeAttrs args [ "fetchpatch" ])
