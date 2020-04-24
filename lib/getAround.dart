List<int> getAround(int index) {
  return [
    (checkNumInList(index - 9)) ? ((index - 9)) : null,
    (checkNumInList(index - 8))
        ? ((index == 8 ||
                index == 17 ||
                index == 26 ||
                index == 35 ||
                index == 44 ||
                index == 53 ||
                index == 62 ||
                index == 71 ||
                index == 80)
            ? null
            : (index - 8))
        : null,
    (checkNumInList(index + 1))
        ? ((index == 8 ||
                index == 17 ||
                index == 26 ||
                index == 35 ||
                index == 44 ||
                index == 53 ||
                index == 62 ||
                index == 71 ||
                index == 80)
            ? null
            : (index + 1))
        : null,
    (checkNumInList(index + 10))
        ? ((index == 8 ||
                index == 17 ||
                index == 26 ||
                index == 35 ||
                index == 44 ||
                index == 53 ||
                index == 62 ||
                index == 71 ||
                index == 80)
            ? null
            : (index + 10))
        : null,
    (checkNumInList(index + 9)) ? ((index + 9)) : null,
    (checkNumInList(index + 8))
        ? ((index == 0 ||
                index == 9 ||
                index == 18 ||
                index == 27 ||
                index == 36 ||
                index == 45 ||
                index == 54 ||
                index == 63 ||
                index == 72)
            ? null
            : (index + 8))
        : null,
    (checkNumInList(index - 1))
        ? ((index == 0 ||
                index == 9 ||
                index == 18 ||
                index == 27 ||
                index == 36 ||
                index == 45 ||
                index == 54 ||
                index == 63 ||
                index == 72)
            ? null
            : (index - 1))
        : null,
    (checkNumInList(index - 10))
        ? ((index == 0 ||
                index == 9 ||
                index == 18 ||
                index == 27 ||
                index == 36 ||
                index == 45 ||
                index == 54 ||
                index == 63 ||
                index == 72)
            ? null
            : (index - 10))
        : null,
  ];
}

bool checkNumInList(int n) {
  if (n > -1 && n < 81)
    return true;
  else
    return false;
}
