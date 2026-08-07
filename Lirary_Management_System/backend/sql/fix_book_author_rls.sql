-- Fix: book_author has RLS enabled but no policy permitting the app's role to
-- read or write it. The backend's Supabase client authenticates as the `anon`
-- role for every request (this app's login/JWT system is custom, built on top
-- of Express middleware in backend/middleware/auth.js + rbac.js -- it does not
-- use Supabase Auth sessions), and access control is already enforced there
-- (authenticate + requireMinRole). So book_author just needs the same
-- permissive access that book / author / category already have for anon.
--
-- Symptoms this fixes:
--   - Admin "Add Book" fails with: new row violates row-level security
--     policy for table "book_author" (INSERT blocked)
--   - Every book shows a blank author, even ones with a real book_author
--     row (e.g. book_id 4 -> author_id 66), because SELECT is blocked too
--   - Searching by author name returns 0 results
--   - Editing a book's author, or deleting a book, silently fails to
--     update/remove its book_author links

drop policy if exists "backend_full_access" on book_author;

create policy "backend_full_access"
on book_author
for all
to anon, authenticated
using (true)
with check (true);
