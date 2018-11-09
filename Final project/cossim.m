function cosine_vectors = cossim(vector_one, vector_two)
cosine_vectors = dot(vector_one, vector_two) / (norm(vector_one) * norm(vector_two));
end

    