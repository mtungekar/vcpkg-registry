vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO mtungekar/persistent-ds
  REF 26df0b27d329c9aa80477ddc606b9a0a61313905
  SHA512 bca8f62ff12b004cbd7eab468a2458a477936ef7fb30598ca46985bbc19dddd0169fc267d2194afef06ff3084ef3a6c38d79d77f9f2bf7211e4c126f7f3fd014
  HEAD_REF main
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)

# Put the license file where vcpkg expects it

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)