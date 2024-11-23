use pyo3::prelude::*;

#[pyfunction]
fn hello(
) -> PyResult<String> {
    Ok("world".to_string())
}

/// A Python module implemented in Rust.
#[pymodule]
fn _rust(_py: Python, m: Bound<PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(hello, &m)?)?;
    Ok(())
}

