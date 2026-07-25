# merge-guard-demo-dbt

The dbt project [Merge Guard](https://github.com/TBD-P2/merge-guard) runs against.

Model and column names **mirror a live DataHub catalog exactly** — they are generated
from it by `seed/gen_dbt_repo.py` in the Merge Guard repo. That is deliberate: Merge
Guard resolves a changed dbt model to a DataHub dataset URN by name, and refuses to
guess when a name is ambiguous, so the names here have to be real.

## Layout

Directories mirror the warehouse schemas, so a file path corresponds to a dataset's
qualified name:

```
models/order_entry/   -> order_entry_db.order_entry.*
models/analytics/     -> order_entry_db.analytics.*
```

## The demo change

`demo/rename-customer-class` renames `customers.customer_class` to `cust_segment`
in both `models/order_entry/customers.sql` and `models/order_entry/schema.yml`.

It looks like a three-line naming cleanup. Downstream it is not:

- `customer_class` is the `GROUP BY` key named in the **"Revenue by Customer Class"**
  glossary term's own definition.
- Column-level lineage reaches **PowerBI and Looker**; dataset-level reaches
  **Tableau** too, plus 12 charts and 3 dashboards.
- A nightly churn model consumes a feature derived from it.

None of which is visible from this repository. That is the problem Merge Guard exists
to solve.

## Licence

Apache-2.0.
