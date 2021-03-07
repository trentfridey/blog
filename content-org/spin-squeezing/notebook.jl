### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 6fb8250a-7a37-11eb-2ca2-9948da9744d9
using QuantumOptics

# ╔═╡ 3f7e9660-7b01-11eb-1539-b9ac98ae4a93
using PyPlot

# ╔═╡ 413e6610-7c91-11eb-3300-79e6fa68b16a
md"_Boilerplate_
---"

# ╔═╡ fce5cd30-7a3a-11eb-2939-250242decb58
function with_pyplot(f::Function)
	f()
	fig = gcf()
	close(fig)
	return fig
end

# ╔═╡ c08f4954-7b02-11eb-1125-f56143988d03
plt[:style][:use]("classic")

# ╔═╡ acb2e8d0-7c91-11eb-0797-75085d372c0f
md"Setting up QuantumOptics
---"

# ╔═╡ 520d4158-7a40-11eb-2cf9-1d736fc415fe
begin 
	N = 10
	b0 = SpinBasis(1//2)
	bN = b0^N
end

# ╔═╡ dda38260-7c91-11eb-17f4-93cb95f2fe0a
md"### Operators"

# ╔═╡ c26a99c0-7c91-11eb-0d04-41ca6efc936a
begin
	# direct operators
	sx = sum(embed(bN, i, sigmax(b0)) for i=1:N)
	sy = sum(embed(bN, i, sigmay(b0)) for i=1:N)
	sz = sum(embed(bN, i, sigmaz(b0)) for i=1:N)
	sy² = sum(embed(bN, i, sigmay(b0)*sigmay(b0)) for i=1:N)
	sz² = sum(embed(bN, i, sigmaz(b0)*sigmaz(b0)) for i=1:N)
	syz = sum(embed(bN, i, sigmay(b0)*sigmaz(b0)) for i=1:N)
	szy = sum(embed(bN, i, sigmaz(b0)*sigmay(b0)) for i=1:N)

	# interaction operators
	sysy = sum(embed(bN, [i,j], [sigmay(b0), sigmay(b0)]) for i=1:N-1 for j=i+1:N)
	szsz = sum(embed(bN, [i,j], [sigmaz(b0), sigmaz(b0)]) for i=1:N-1 for j=i+1:N)

	sysz = sum(embed(bN, [i,j], [sigmay(b0), sigmaz(b0)]) for i=1:N-1 for j=i+1:N)
	szsy = sum(embed(bN, [i,j], [sigmaz(b0), sigmay(b0)]) for i=1:N-1 for j=i+1:N)

	# Hamiltonian
	H = 0.5*szsz
end

# ╔═╡ c8456b74-7c94-11eb-0d9b-83ff5d30996b
md"### Time evolution"

# ╔═╡ 4ebc9672-7a43-11eb-0a86-8fa2fb9ab772
begin
	θ₀, ϕ₀ = π/2, 0
	Ψ₀ = tensor([coherentspinstate(b0, θ₀, ϕ₀) for i=1:N]...)
	δt = 0.5^10
	t₀ = 0
	τ = pi
	time_range = [t₀:δt:τ;]
	t_out, Ψₜ = timeevolution.schroedinger(time_range, Ψ₀, H)
end

# ╔═╡ d22932ce-7c94-11eb-1971-edc43bec9673
md"### Q-functions"

# ╔═╡ 801003c0-7b07-11eb-0f29-41ef6056b1c4
function qfuncN(Ψ, Nθ, Nϕ)
	psi_bra_data = Ψ.data'
	psi_ket(θ,ϕ) = tensor([coherentspinstate(b0,θ,ϕ) for i=1:N]...)
	result = Array{Float64}(undef, Nθ, Nϕ)
    @inbounds for i = 0:Nθ-1, j = 0:Nϕ-1
        result[i+1,j+1] = 1/(2pi)*abs2(psi_bra_data*psi_ket(pi-i*pi/(Nθ-1),j*2pi/(Nϕ-1)-pi).data)
	end
	return result
end

# ╔═╡ a1de507c-7c94-11eb-2bef-7f8b89ac0555
begin
	Ntheta = 100
	Nphi = 200
end

# ╔═╡ fa40345c-7b06-11eb-22ce-d5f0e189472e
begin
	Q0 = qfuncN(Ψ₀, Ntheta, Nphi)
	with_pyplot() do
		subplot(aspect="equal")
		pcolor([0:2pi/(Nphi-1):2pi;],[0:pi/(Ntheta-1):pi;], Q0, cmap="plasma")
		title(L"Q(\theta,\phi)", size=22)
		xlabel(L"\phi", size=18)
		xlim(0,2pi)
		ylabel(L"\theta", size=18)
		ylim(0,pi)
		tight_layout()
		# savefig("images/qplot0.png", transparent=true)
	end
end

# ╔═╡ 39fa8e32-7af8-11eb-3d4b-39cb20d7c4ae
begin
	Q = qfuncN(Ψₜ[12], Ntheta, Nphi)
	with_pyplot() do
		subplot(aspect="equal")
		pcolor([0:2pi/(Nphi-1):2pi;],[0:pi/(Ntheta-1):pi;], Q, cmap="plasma")
		title(L"Q(\theta,\phi)", size=22)
		xlabel(L"\phi", size=18)
		xlim(0,2pi)
		ylabel(L"\theta", size=18)
		ylim(0,pi)
		tight_layout()
		# savefig("images/qplot.png", transparent=true)
	end
end

# ╔═╡ ef7aabbe-7c94-11eb-2865-6f32d3a29692
md"### Squeezing"

# ╔═╡ f72c3a96-7bca-11eb-0b7d-e15c7a5457ab
md"The normalized directional variance is:

\begin{equation}
\xi^2(\varphi) = \frac{\sigma_\varphi^2}{|\langle \vec{S} \rangle|^2}
\end{equation}

where

$$\sigma_{\varphi}^2 = \langle S_z^2 \sin^2{\varphi} + S_y^2 \cos^2{\varphi} + \{S_y, S_z\}\sin{2\varphi}\rangle - \langle S_z \sin{\varphi} + S_y \cos{\varphi}\rangle^2$$

$$=\sigma_z^2\sin^2\varphi + \sigma_y^2\cos^2\varphi + (\langle \{S_y, S_z \} \rangle - \langle S_z\rangle\langle S_y \rangle)\sin{2\varphi}$$
"

# ╔═╡ ab285392-7c96-11eb-1040-97cbc23a4e3e
begin
	bloch_vec(state) = sqrt(expect(sx,state)^2 + expect(sy,state)^2 + expect(sz,state)^2)
	
	σy²(state) = expect(sysy+sy², state) - expect(sy, state)^2
	
	σz²(state) = expect(szsz+sz², state) - expect(sz, state)^2
	
	covar_yz(state) = expect(sysz + syz, state)+expect(szsy + szy, state) - expect(sy, state)*expect(sz, state)
	
	ξ(ϕ, state) = (1/bloch_vec(state)^2)*(σy²(state)*sin(ϕ)^2 + σz²(state)*cos(ϕ)^2 + covar_yz(state)*sin(2ϕ))
end

# ╔═╡ 6f831cfa-7bcc-11eb-1342-0f33e194ab0d
md"The minimizing angle $\varphi^*$ is found in the usual way:

$$\left.\frac{d}{d\varphi}\sigma_\varphi^2\right|_{\varphi^*} = 2(\sigma_z^2 - \sigma_y^2)\sin{2\varphi} + 2(\langle\{S_y, S_z\}\rangle - \langle S_y \rangle \langle S_z \rangle)\cos{2\varphi}=0$$

$$\implies \tan{2\varphi^*} = \frac{(\sigma_y^2 - \sigma_z^2)}{\langle\{S_y,S_z\}\rangle - \langle S_y \rangle \langle S_z \rangle}$$
"

# ╔═╡ 48b44eaa-7bce-11eb-0e33-95929c4ca169
begin 
	var_diff(state) = σy²(state) - σz²(state) 
	φ(state) = 0.5*atan(real(var_diff(state)), real(covar_yz(state)))
end

# ╔═╡ c443902a-7c97-11eb-1f84-9f33b2dc240d
begin
	with_pyplot() do
		plot(time_range,[-log(10,real(ξ(φ(Ψₜ[i]),Ψₜ[i]))) for (i,_) ∈ enumerate(time_range)])
		title("Squeezing amount vs. time", size=22)
		xlabel(L"t", size=18)
		xlim(t₀,τ)
		ylabel(L"-10\log_{10}\xi^2", size=18)
		tight_layout()
		savefig("images/xiplot.png", transparent=true)
	end
end

# ╔═╡ 35daba7e-7f5e-11eb-3df6-afbb6e52b773
ξ_map = [10log(10,max(real(ξ(ϕ,Ψₜ[i])),0)) for ϕ ∈ [-pi:0.01*pi:pi;], i=1:length(time_range)]

# ╔═╡ d85dd6b8-7c99-11eb-03d2-af03466e508b
begin
	with_pyplot() do
		plot(time_range, [real(φ(Ψₜ[i])) for (i,_) ∈ enumerate(time_range)])
		contourf(time_range,[-pi:0.01*pi:pi;], -ξ_map, 15, cmap="plasma_r")
		colorbar()
		title(L"\varphi^*(t)", size=22)
		xlabel(L"t", size=18)
		xlim(t₀,τ)
		ylabel(L"\varphi^*", size=18)
		ylim(-π,π)
		tight_layout()
	end
end

# ╔═╡ 95fb1f86-7f57-11eb-2756-f10ba58434bc
begin
	with_pyplot() do
		contourf(time_range,[-pi:0.01*pi:pi;], -ξ_map, 20, cmap="plasma")
		colorbar()
		xlim(0,τ)
		ylim(-pi,pi)
	end
end

# ╔═╡ d8f6ad70-7f5f-11eb-2c3f-b1d3cfb308ab
[-pi:0.1*pi:pi;]

# ╔═╡ Cell order:
# ╠═413e6610-7c91-11eb-3300-79e6fa68b16a
# ╠═6fb8250a-7a37-11eb-2ca2-9948da9744d9
# ╠═3f7e9660-7b01-11eb-1539-b9ac98ae4a93
# ╠═fce5cd30-7a3a-11eb-2939-250242decb58
# ╠═c08f4954-7b02-11eb-1125-f56143988d03
# ╠═acb2e8d0-7c91-11eb-0797-75085d372c0f
# ╠═520d4158-7a40-11eb-2cf9-1d736fc415fe
# ╠═dda38260-7c91-11eb-17f4-93cb95f2fe0a
# ╠═c26a99c0-7c91-11eb-0d04-41ca6efc936a
# ╠═c8456b74-7c94-11eb-0d9b-83ff5d30996b
# ╠═4ebc9672-7a43-11eb-0a86-8fa2fb9ab772
# ╠═d22932ce-7c94-11eb-1971-edc43bec9673
# ╠═801003c0-7b07-11eb-0f29-41ef6056b1c4
# ╠═a1de507c-7c94-11eb-2bef-7f8b89ac0555
# ╠═fa40345c-7b06-11eb-22ce-d5f0e189472e
# ╠═39fa8e32-7af8-11eb-3d4b-39cb20d7c4ae
# ╠═ef7aabbe-7c94-11eb-2865-6f32d3a29692
# ╠═f72c3a96-7bca-11eb-0b7d-e15c7a5457ab
# ╠═ab285392-7c96-11eb-1040-97cbc23a4e3e
# ╠═6f831cfa-7bcc-11eb-1342-0f33e194ab0d
# ╠═48b44eaa-7bce-11eb-0e33-95929c4ca169
# ╠═d85dd6b8-7c99-11eb-03d2-af03466e508b
# ╠═c443902a-7c97-11eb-1f84-9f33b2dc240d
# ╠═35daba7e-7f5e-11eb-3df6-afbb6e52b773
# ╠═95fb1f86-7f57-11eb-2756-f10ba58434bc
# ╠═d8f6ad70-7f5f-11eb-2c3f-b1d3cfb308ab
