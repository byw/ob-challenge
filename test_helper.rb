def make_bond(name, term, bond_yield)
  {
    bond: name,
    term: BigDecimal(term.to_s),
    yield: BigDecimal(bond_yield.to_s)
  }
end
