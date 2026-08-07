const { supabase } = require('./database');

function splitName(name) {
  const trimmed = (name || '').trim();
  const sp = trimmed.indexOf(' ');
  return sp === -1 ? { first_name: trimmed, last_name: '' }
                    : { first_name: trimmed.slice(0, sp), last_name: trimmed.slice(sp + 1) };
}

async function findOrCreateAuthor(name) {
  const { first_name, last_name } = splitName(name);

  const { data: existing } = await supabase.from('author')
    .select('author_id').eq('first_name', first_name).eq('last_name', last_name).maybeSingle();
  if (existing) return existing.author_id;

  const { data, error } = await supabase.from('author')
    .insert({ first_name, last_name }).select('author_id').single();
  if (error) throw error;
  return data.author_id;
}

async function findOrCreateCategory(name) {
  if (!name) return null;
  const { data: existing } = await supabase.from('category')
    .select('category_id').eq('category_name', name).maybeSingle();
  if (existing) return existing.category_id;

  const { data, error } = await supabase.from('category')
    .insert({ category_name: name }).select('category_id').single();
  if (error) throw error;
  return data.category_id;
}

module.exports = { splitName, findOrCreateAuthor, findOrCreateCategory };
